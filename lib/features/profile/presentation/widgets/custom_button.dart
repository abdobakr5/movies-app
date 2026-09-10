import 'package:flutter/material.dart';
import '../../../../core/utlis/app_colors.dart';
import '../../../../core/utlis/app_styles.dart';

class CustomButton extends StatelessWidget{
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  const CustomButton({
    required this.backgroundColor,
    required this.onPressed,
    required this.text,
    required this.textColor,
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
            borderRadius: BorderRadiusGeometry.circular(12),
          )
        ),
        onPressed: onPressed, child:Text(text,
        style: AppStyles.buttonStyle.copyWith(color: textColor),),),
    );
  }
}