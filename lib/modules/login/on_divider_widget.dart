import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';

class OnDividerWidget extends StatelessWidget {
  const OnDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.primary,
            thickness: 1,
            indent: 70,
            endIndent: 14,
          ),
        ),
        Text(
          'OR',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.primary,
            thickness: 1,
            indent: 14,
            endIndent: 70,
          ),
        ),
      ],
    );
  }
}
