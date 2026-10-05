import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeMoreTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (onSeeMoreTap != null)
            GestureDetector(
              onTap: onSeeMoreTap,
              child: const Row(
                children: [
                  Text(
                    'See More ',
                    style: TextStyle(
                      color: AppColors.starYellow,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.starYellow,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
