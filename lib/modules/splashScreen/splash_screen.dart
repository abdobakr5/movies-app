import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:movies_app/core/app_assets/app_assets.dart';
import 'package:movies_app/modules/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ZoomIn(
                duration: const Duration(seconds: 2),
                child: Center(
                  child: Hero(
                    tag: "logo",
                    child: Image.asset(AppAssets.appLogo, width: 309),
                  ),
                ),
              ),
            ),
            FadeInUp(
              onFinish: (direction) {
                Future.delayed(const Duration(seconds: 1), () {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                      // TODO: Implement navigation to the next screen after the splash screen.
                      // MaterialPageRoute(
                      //   builder: (context) {
                      //     return const OnboardingScreen();
                      //   },
                      // ),
                    );
                  }
                });
              },
              delay: const Duration(seconds: 2),
              child: Image.asset(AppAssets.routeLogo, width: 214),
            ),
          ],
        ),
      ),
    );
  }
}
