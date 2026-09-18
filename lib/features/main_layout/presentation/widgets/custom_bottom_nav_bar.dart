import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/app_assets/app_icons.dart';
import 'package:movies_app/core/theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.navBarBackground,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            index: 0,
            iconPath: AppIcons.home,
          ),
          _buildNavItem(
            index: 1,
            iconPath: AppIcons.search,
          ),
          _buildNavItem(
            index: 2,
            iconPath: AppIcons.explore,
          ),
          _buildNavItem(
            index: 3,
            iconPath: AppIcons.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
  }) {
    final isSelected = currentIndex == index;
    final iconColor =
        isSelected ? AppColors.primaryColor : AppColors.iconInactive;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            iconColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
