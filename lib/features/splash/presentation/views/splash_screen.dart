import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies_app/core/app_routes/app_routes.dart';
import 'package:movies_app/core/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _checkUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        AppRoutes.mainLayout(),
      );
    } else if (onboardingSeen) {
      Navigator.pushReplacement(
        context,
        AppRoutes.login(),
      );
    } else {
      Navigator.pushReplacement(
        context,
        AppRoutes.onboarding1(),
      );
    }
  }
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
                Future.delayed(
                  const Duration(seconds: 1),
                  _checkUserStatus,
                );
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
