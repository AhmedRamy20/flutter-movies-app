import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_event.dart';
import 'package:movies_app/extension/sized_box.dart';

class VerifiedEmail extends StatefulWidget {
  const VerifiedEmail({super.key});

  @override
  State<VerifiedEmail> createState() => _VerifiedEmailState();
}

class _VerifiedEmailState extends State<VerifiedEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email verification"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mark_email_read_outlined,
                size: 90,
                color: Colors.blueAccent,
              ),

              25.hight,
              const Text(
                "We’ve sent a verification link to your email",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              10.hight,
              const Text(
                "Please check your inbox and verify your email to continue using the app.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              40.hight,
              //* Done in register
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      const AuthEventSendEmailVerification(),
                    );
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Resend verification email"),
                ),
              ),
              15.hight,

              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLoggingOut());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text("Back to login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
