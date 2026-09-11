import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/app_routes/app_routes.dart';

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
                    Navigator.pushReplacement(
                      context,
                      AppRoutes.onboarding1(),
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
