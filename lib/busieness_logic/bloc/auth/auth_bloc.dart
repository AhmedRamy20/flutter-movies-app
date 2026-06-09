import 'package:bloc/bloc.dart';
import 'package:movies_app/data/web_service/auth/abstract_auth_provider.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_event.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
    : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventInitialize>((event, emit) async {
      // so we have to initialize using provider
      await provider.initialize();
      // so the firebase is up and running after initialize so if i get the current user
      // and it is null so the user is currently logged out if not so he is logged in
      final user = provider.currentUser;

      if (user == null) {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateMustVerify(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(user: user, isLoading: false));
      }
    });

    //? Login
    on<AuthEventLoggingIn>((event, emit) async {
      emit(
        const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
          loadingText: "Please wait while Logging in..",
        ),
      );
      try {
        final user = await provider.logIn(
          email: event.email,
          password: event.password,
        );

        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(const AuthStateMustVerify(isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    //? Log Out
    on<AuthEventLoggingOut>((event, emit) async {
      try {
        await provider.logOut();

        emit(AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    //? send Verificatiom
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    //? Register
    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(email: email, password: password);

        await provider.sendEmailVerification();
        emit(AuthStateMustVerify(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateRegistering(exception: e, isLoading: false));
      }
    });

    //? Should Registere
    on<AuthEventShouldRegister>((event, emit) async {
      emit(const AuthStateRegistering(exception: null, isLoading: false));
    });

    //? forget PassEvent
    on<AuthEventForgetPassword>((event, emit) async {
      emit(
        AuthStateForgetPassword(
          isLoading: false,
          exception: null,
          hasSentTheEmail: false,
        ),
      );
      final email = event.email;
      if (email == null) {
        return;
      }

      emit(
        AuthStateForgetPassword(
          isLoading: true,
          exception: null,
          hasSentTheEmail: false,
        ),
      );
      bool didSendEmail;
      Exception? exception;
      try {
        // print('Email: "$email"');
        await provider.sendPasswordReset(email: email);
        didSendEmail = true;
        exception = null;
      } on Exception catch (e) {
        didSendEmail = false;
        exception = e;
        // print('Firebase error code: ${e.hashCode}');
      }
      emit(
        AuthStateForgetPassword(
          isLoading: false,
          exception: exception,
          hasSentTheEmail: didSendEmail,
        ),
      );
    });
  }
}
