import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
  });

  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;

  OutlineInputBorder _border([Color color = Colors.transparent]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,

      style: const TextStyle(color: AppColors.white, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.field,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.white, fontSize: 16),
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 18, end: 4),
          child: Icon(prefixIcon, color: AppColors.white, size: 30),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 12,
        ),
        errorStyle: const TextStyle(color: AppColors.error),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(AppColors.primary),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error),
      ),
    );
  }
}
