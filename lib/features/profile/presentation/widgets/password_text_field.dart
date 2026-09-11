import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import 'custom_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;

  const PasswordTextField({
    super.key,
    this.controller,
    required this.hintText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;

  void _toggleVisibility() => setState(() => _isObscured = !_isObscured);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      hintText: widget.hintText,
      icon: Icons.lock,
      obscureText: _isObscured,
      suffixIcon: IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: AppColors.textWhite,
        ),
        onPressed: _toggleVisibility,
      ),
    );
  }
}
