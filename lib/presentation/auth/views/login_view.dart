import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/data/web_service/auth/auth_exceptions.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_event.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_state.dart';
import 'package:movies_app/core/extension/sized_box.dart';
import 'package:movies_app/utils/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.name});

  final String name;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _showPassword = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  late String message;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is InvalidEmailFormatAuthException) {
            await showErrorDialog(context, 'Invalid email format.');
          } else if (state.exception is InvalidEmailOrPasswordAuthException) {
            await showErrorDialog(
              context,
              "Can't find a user with these credentials",
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              "Failed to Login with these credintials",
            );
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset("assets/images/watch.jpg", fit: BoxFit.fill),
            ),

            //grad
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 40.hight,
                            const Text(
                              "Welcome Back..",
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            8.hight,

                            const Text(
                              "Explore your favorite movies anytime",
                              style: TextStyle(color: Colors.white70),
                            ),

                            30.hight,
                            TextField(
                              controller: _email,
                              style: const TextStyle(color: Colors.white),
                              // keyboardType: TextInputType.emailAddress,
                              decoration: _inputDecoration(
                                "Email",
                                Icons.email,
                              ),
                            ),
                            15.hight,

                            TextField(
                              controller: _password,
                              obscureText: !_showPassword,
                              style: const TextStyle(color: Colors.white),
                              decoration:
                                  _inputDecoration(
                                    "Password",
                                    Icons.lock,
                                  ).copyWith(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white70,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                    ),
                                  ),
                            ),
                            // 8.hight,
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                    const AuthEventForgetPassword(email: null),
                                  );
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                            10.hight,

                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final email = _email.text.trim();
                                  final password = _password.text.trim();

                                  if (email.isEmpty || password.isEmpty) {
                                    await showErrorDialog(
                                      context,
                                      "Please enter both email and password.",
                                    );
                                    return;
                                  }

                                  context.read<AuthBloc>().add(
                                    AuthEventLoggingIn(
                                      email: email,
                                      password: password,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text("Login"),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "New here?",
                                  style: TextStyle(color: Colors.white70),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                      const AuthEventShouldRegister(),
                                    );
                                  },
                                  child: const Text(
                                    "Create account",
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.08),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
