import 'package:flutter/material.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../profile/presentation/widgets/avatar_selector.dart';
import '../../../profile/presentation/widgets/custom_button.dart';
import '../../../profile/presentation/widgets/custom_text_field.dart';
import '../../../profile/presentation/widgets/language_toggle.dart';
import '../../../profile/presentation/widgets/password_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      AvatarSelector(avatarPaths: AppAssets.allAvatars),
                      const SizedBox(height: 24),

                      const CustomTextField(
                        hintText: 'Name',
                        icon: Icons.badge,
                      ),
                      const SizedBox(height: 16),

                      const CustomTextField(
                        hintText: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      const PasswordTextField(hintText: 'Password'),
                      const SizedBox(height: 16),

                      const PasswordTextField(hintText: 'Confirm Password'),
                      const SizedBox(height: 16),

                      const CustomTextField(
                        hintText: 'Phone Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 28),

                      CustomButton(
                        text: 'Create Account',
                        backgroundColor: AppColors.primaryYellow,
                        textColor: AppColors.black,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 16),

                      _buildLoginRow(context),
                      const SizedBox(height: 20),

                      Center(
                        child: LanguageToggleButton(
                          leftFlagPath: AppAssets.flagLeft,
                          rightFlagPath: AppAssets.flagRight,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryYellow),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Register',
              style: TextStyle(
                color: AppColors.primaryYellow,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }

  Widget _buildLoginRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already Have Account ? ',
          style: TextStyle(color: AppColors.textWhite),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, AppRoutes.login());
          },
          child: const Text(
            'Login',
            style: TextStyle(
              color: AppColors.primaryYellow,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
