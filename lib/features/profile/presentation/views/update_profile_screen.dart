import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  
  final List<String> avatars = [
    AppAssets.avatar1,
    AppAssets.avatar2,
    AppAssets.avatar3,
    AppAssets.avatar4,
    AppAssets.avatar5,
    AppAssets.avatar6,
    AppAssets.avatar7,
    AppAssets.avatar8,
    AppAssets.avatar9,
  ];
  
  String selectedAvatar = AppAssets.avatar1;

  void _showAvatarBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              final bool isSelected = selectedAvatar == avatars[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = avatars[index];
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryYellow.withValues(alpha: 0.4) : AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primaryYellow,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(avatars[index]),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryYellow),
        ),
        title: TextButton(
          onPressed: _showAvatarBottomSheet,
          child: const Text(
            AppStrings.pickAvatar,
            style: TextStyle(
              color: AppColors.primaryYellow,
              fontSize: 16,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(selectedAvatar),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 30),
              CustomTextField(
                controller: nameController,
                icon: Icons.person_outline,
                hintText: AppStrings.nameHint,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: phoneController,
                icon: Icons.phone_outlined,
                hintText: AppStrings.phoneHint,
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.darkBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(AppStrings.resetPassword, style: AppStyles.bodyStyle),
              ),
              const SizedBox(height: 260),
              CustomButton(
                backgroundColor: AppColors.red,
                onPressed: () {},
                text: AppStrings.deleteAccount,
                textColor: AppColors.textWhite,
              ),
              const SizedBox(height: 16),
              CustomButton(
                backgroundColor: AppColors.primaryYellow,
                onPressed: () {},
                text: AppStrings.updateData,
                textColor: AppColors.surfaceColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
