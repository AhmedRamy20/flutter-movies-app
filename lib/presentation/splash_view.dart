import 'package:flutter/material.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/gate_decide.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const GateDecideViews()),
      );
    });
    return Scaffold(
      backgroundColor: AppColors.darkBackGround,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),

              child: Image.asset("assets/images/logo.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}
