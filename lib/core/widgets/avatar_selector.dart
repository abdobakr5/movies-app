import 'package:flutter/material.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/theme/app_colors.dart';

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
  static const int _selectedFlex = 5;
  static const int _unselectedFlex = 3;

  void _selectAvatar(int index) {
    setState(() => _selectedIndex = index);
    widget.onAvatarSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final avatars = widget.avatarPaths.length > 3
        ? widget.avatarPaths.sublist(0, 3)
        : widget.avatarPaths;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(avatars.length, (index) {
            final bool isSelected = index == _selectedIndex;

            return Expanded(
              flex: isSelected ? _selectedFlex : _unselectedFlex,
              child: GestureDetector(
                onTap: () => _selectAvatar(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(avatars[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.avatar,
          style: const TextStyle(color: AppColors.textWhite, fontSize: 16),
        ),
      ],
    );
  }
}