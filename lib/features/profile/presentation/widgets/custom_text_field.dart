import 'package:flutter/material.dart';
import 'package:movies_app/core/utlis/app_styles.dart';
import '../../../../core/utlis/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    this.controller,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppStyles.bodyStyle,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.textWhite),
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: AppStyles.bodyStyle,
        filled: true,
        fillColor: AppColors.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}