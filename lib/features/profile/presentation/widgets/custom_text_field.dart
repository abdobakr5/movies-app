import 'package:flutter/material.dart';
import 'package:movies_app/core/utlis/app_styles.dart';
import '../../../../core/utlis/app_colors.dart';

class CustomTextField extends StatelessWidget{
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  
  const CustomTextField({
    required this.controller,
    required this.icon,
    required this.hintText,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppStyles.bodyStyle,
      decoration: InputDecoration(
        prefixIcon: Icon(icon,color: AppColors.textWhite,),
        hintText: hintText,
        hintStyle: AppStyles.bodyStyle,
        filled: true,
        fillColor: AppColors.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        )
      ),
    );
  } 
}