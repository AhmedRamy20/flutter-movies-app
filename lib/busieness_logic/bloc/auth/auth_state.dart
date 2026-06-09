import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app/data/web_service/auth/auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = "Please wait a moment..",
  });
}

// to like display loading sceen when for example indicate we are initialize firebase and when not initialized
// we tell the ui u should trigger AuthEventInitialize
class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading})
    : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;

  const AuthStateLoggedIn({required this.user, required bool isLoading})
    : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(isLoading: isLoading, loadingText: loadingText);

  // for the bloc not to rebuild every time cause if there 2 state are exactly the same bloc will say they are not and this is old state
  // and this is new state and will rebuild again NOT GOOOD
  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({required this.exception, required bool isLoading})
    : super(isLoading: isLoading);
}

class AuthStateMustVerify extends AuthState {
  const AuthStateMustVerify({required bool isLoading})
    : super(isLoading: isLoading);
}

class AuthStateForgetPassword extends AuthState {
  final Exception? exception;
  final bool hasSentTheEmail;
  const AuthStateForgetPassword({
    required bool isLoading,
    required this.exception,
    required this.hasSentTheEmail,
  }) : super(isLoading: isLoading);
}
