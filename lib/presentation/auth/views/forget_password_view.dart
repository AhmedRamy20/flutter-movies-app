import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/data/web_service/auth/auth_exceptions.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_event.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_state.dart';
import 'package:movies_app/core/extension/sized_box.dart';
import 'package:movies_app/utils/dialogs/error_dialog.dart';
import 'package:movies_app/utils/dialogs/password_send_email_dialog.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final TextEditingController _emailPassSendController;

  @override
  void initState() {
    super.initState();
    _emailPassSendController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailPassSendController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthStateForgetPassword) {
            if (state.hasSentTheEmail) {
              _emailPassSendController.clear();
              await sendEmailDialog(context: context);
            }

            if (state.exception is InvalidEmailFormatAuthException) {
              await showErrorDialog(context, 'Invalid email format.');
            } else if (state.exception is UserNotFoundAuthException) {
              await showErrorDialog(context, 'User Not Found');
            } else if (state.exception is GenericAuthException) {
              await showErrorDialog(context, 'Something Wrong happened..');
            }
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/password.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(color: Colors.black.withOpacity(0.75)),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.lock_reset,
                        color: Colors.white,
                        size: 60,
                      ),

                      20.hight,

                      const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      8.hight,

                      const Text(
                        "Enter your email and we’ll send you a reset link",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),

                      25.hight,

                      TextField(
                        controller: _emailPassSendController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: AppColors.primary,

                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white10,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.white70,
                          ),
                          hintText: "Email",
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),

                      20.hight,

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            final email = _emailPassSendController.text.trim();

                            if (email.isEmpty) {
                              showErrorDialog(
                                context,
                                "Please enter your email",
                              );
                              return;
                            }

                            context.read<AuthBloc>().add(
                              AuthEventForgetPassword(email: email),
                            );
                          },
                          child: const Text(
                            "Send Reset Link",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      15.hight,

                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthEventLoggingOut());
                        },
                        child: const Text(
                          "Back to Login",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
