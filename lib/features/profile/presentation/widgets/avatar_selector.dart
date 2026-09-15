import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class AvatarSelector extends StatefulWidget {
  final List<String> avatarPaths;
  final int initialIndex;
  final ValueChanged<int>? onAvatarSelected;

  const AvatarSelector({
    super.key,
    required this.avatarPaths,
    this.initialIndex = 1,
    this.onAvatarSelected,
  });

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  late int _selectedIndex = widget.initialIndex;

  void _selectAvatar(int index) {
    setState(() => _selectedIndex = index);
    widget.onAvatarSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            widget.avatarPaths.length > 3 ? 3 : widget.avatarPaths.length,
                (index) {
              final bool isSelected = index == _selectedIndex;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () => _selectAvatar(index),
                  child: CircleAvatar(
                    radius: isSelected ? 52 : 36,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(widget.avatarPaths[index]),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Avatar',
          style: TextStyle(color: AppColors.textWhite, fontSize: 16),
        ),
      ],
    );
  }
}
