import 'package:flutter/material.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final String? iconPath;

  const CustomButton({
    super.key,
    this.backgroundColor = AppColors.primaryYellow,
    required this.onPressed,
    required this.text,
    this.textColor = AppColors.black,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )
        ),
        onPressed: onPressed, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              Image.asset(iconPath!, height: 24, errorBuilder: (context, error, stackTrace) => const SizedBox.shrink()),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: AppStyles.buttonStyle.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
