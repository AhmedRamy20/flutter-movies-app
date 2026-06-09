import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_event.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_state.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/helpers/loading_helper.dart';
import 'package:movies_app/presentation/auth/views/email_verified.dart';
import 'package:movies_app/presentation/auth/views/forget_password_view.dart';
import 'package:movies_app/presentation/auth/views/login_view.dart';
import 'package:movies_app/presentation/auth/views/registe_view.dart';
import 'package:movies_app/presentation/home/views/bottom_nav.dart';

class GateDecideViews extends StatefulWidget {
  const GateDecideViews({super.key});

  @override
  State<GateDecideViews> createState() => _GateDecideViewsState();
}

class _GateDecideViewsState extends State<GateDecideViews> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEventInitialize());
  }

  @override
  Widget build(BuildContext context) {
    // it was only BlocBuilder but we want to do some sidefects on the states that changes that have isLoading
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? "Please Wait a moment",
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const BottomNavEntry();
        } else if (state is AuthStateMustVerify) {
          return const VerifiedEmail();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView(name: "Login");
        } else if (state is AuthStateRegistering) {
          return const RegisterView(title: "Register");
        } else if (state is AuthStateForgetPassword) {
          return const ForgetPasswordView();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
      },
    );
  }
}
