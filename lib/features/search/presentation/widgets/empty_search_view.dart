import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';

class EmptySearchView extends StatelessWidget {
  const EmptySearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.popcorn,
        width: 180,
        height: 180,
        fit: BoxFit.contain,
      ),
    );
  }
}