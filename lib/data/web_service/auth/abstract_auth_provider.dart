import 'package:movies_app/data/web_service/auth/auth_user.dart';

//** Our Contract that will has its IMPL */
abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<void> sendPasswordReset({required String email});

  Future<AuthUser> logIn({required String email, required String password});

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<void> sendEmailVerification();

  Future<void> initialize();
}
