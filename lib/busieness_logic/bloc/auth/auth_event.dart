import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

// for initialize firebase just a method to call
class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLoggingIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLoggingIn({required this.email, required this.password});
}

class AuthEventLoggingOut extends AuthEvent {
  const AuthEventLoggingOut();
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  const AuthEventRegister({required this.email, required this.password});
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventForgetPassword extends AuthEvent {
  final String? email;
  const AuthEventForgetPassword({required this.email});
}
