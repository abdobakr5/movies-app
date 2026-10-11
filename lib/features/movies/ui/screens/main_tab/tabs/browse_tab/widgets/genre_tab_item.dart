import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';

class GenreTabItem extends StatelessWidget {
  final String genre;
  final bool isSelected;
  final VoidCallback onTap;

  const GenreTabItem({
    super.key,
    required this.genre,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.genreSelected : AppColors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.genreSelected,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            genre,
            style: TextStyle(
              color: isSelected ? AppColors.black : AppColors.genreSelected,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
