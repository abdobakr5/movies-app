import 'package:flutter/material.dart';
import 'package:movies_app/core/app_assets/app_assets.dart';
import 'package:movies_app/core/theme/app_colors.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({
    super.key,
    required this.isEnglish,
    required this.onChanged,
  });
 
  final bool isEnglish;
  final ValueChanged<bool> onChanged;
 
  static const double _slotSize = 36;
  static const double _flagSize = 28;
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 92,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Stack(
          children: [
            // الأعلام — ثابتة LTR عشان متتقلبش لما اللغة تبقى عربي
            Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _flag(AppAssets.usFlag, () => onChanged(true)),
                _flag(AppAssets.egFlag, () => onChanged(false)),
              ],
            ),
 
            // الدايرة الصفرا حوالين العلم المختار
            IgnorePointer(
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment:
                    isEnglish ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: _slotSize,
                  height: _slotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _flag(String asset, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: _slotSize,
        height: _slotSize,
        child: Center(
          child: ClipOval(
            child: Image.asset(
              asset,
              width: _flagSize,
              height: _flagSize,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}