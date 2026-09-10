import 'package:flutter/material.dart';

import '../../modules/onBoarding/screens/onboarding1_screen.dart';
import '../../modules/onBoarding/screens/onboarding2_screen.dart';
import '../../modules/onBoarding/screens/onboarding3_screen.dart';

class AppRoutes {
  static Route onboarding1() =>
      MaterialPageRoute(builder: (_) => const onBoarding1());

  static Route onboarding2() =>
      MaterialPageRoute(builder: (_) => const onBoarding2());

  static Route onboarding3() =>
      MaterialPageRoute(builder: (_) => const onBoarding3());
}
