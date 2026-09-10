import 'package:flutter/material.dart';
import '../../../../core/utlis/app_colors.dart';

class LanguageToggleButton extends StatefulWidget {
  final String leftFlagPath;
  final String rightFlagPath;
  final ValueChanged<bool>? onToggle;

  const LanguageToggleButton({
    super.key,
    required this.leftFlagPath,
    required this.rightFlagPath,
    this.onToggle,
  });

  @override
  State<LanguageToggleButton> createState() => _LanguageToggleButtonState();
}

class _LanguageToggleButtonState extends State<LanguageToggleButton> {
  bool _isLeftSelected = true;

  void _toggle() {
    setState(() => _isLeftSelected = !_isLeftSelected);
    widget.onToggle?.call(_isLeftSelected);
  }

  Widget _buildFlag(String path, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 32,
      height: 32,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primaryYellow : Colors.transparent,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.flag, size: 16, color: Colors.white);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          border: Border.all(color: AppColors.primaryYellow, width: 1.5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFlag(widget.leftFlagPath, _isLeftSelected),
            const SizedBox(width: 8),
            _buildFlag(widget.rightFlagPath, !_isLeftSelected),
          ],
        ),
      ),
    );
  }
}