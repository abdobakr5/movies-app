import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/app_routes/app_routes.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/features/auth/presentation/cubit/register_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/register_state.dart';
import 'package:movies_app/features/profile/presentation/widgets/avatar_selector.dart';
import 'package:movies_app/features/profile/presentation/widgets/custom_button.dart';
import 'package:movies_app/features/profile/presentation/widgets/custom_text_field.dart';
import 'package:movies_app/features/profile/presentation/widgets/language_toggle.dart';
import 'package:movies_app/features/profile/presentation/widgets/password_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.accountCreatedSuccessfully),
                      backgroundColor: AppColors.green,
                    ),
                  );
                  Navigator.pushReplacement(context, AppRoutes.login());
                } else if (state is RegisterFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: AppColors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final cubit = BlocProvider.of<RegisterCubit>(context);
                final l10n = AppLocalizations.of(context)!;

                return Column(
                  children: [
                    _buildHeader(context),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: cubit.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 12),
                              AvatarSelector(
                                avatarPaths: AppAssets.allAvatars,
                                onAvatarSelected: cubit.selectAvatar,
                              ),
                              const SizedBox(height: 24),
                              CustomTextField(
                                controller: cubit.nameController,
                                hintText: l10n.name,
                                icon: Icons.badge,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return l10n.pleaseEnterName;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: cubit.emailController,
                                hintText: l10n.email,
                                icon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return l10n.pleaseEnterEmail;
                                  }
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return l10n.pleaseEnterValidEmail;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              PasswordTextField(
                                controller: cubit.passwordController,
                                hintText: l10n.password,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return l10n.passwordMinLength;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              PasswordTextField(
                                controller: cubit.confirmPasswordController,
                                hintText: l10n.confirmPassword,
                                validator: (value) {
                                  if (value != cubit.passwordController.text) {
                                    return l10n.passwordsDoNotMatch;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: cubit.phoneController,
                                hintText: l10n.phoneNumber,
                                icon: Icons.phone,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return l10n.pleaseEnterPhone;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 28),
                              state is RegisterLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryYellow,
                                      ),
                                    )
                                  : CustomButton(
                                      text: l10n.createAccount,
                                      backgroundColor: AppColors.primaryYellow,
                                      textColor: AppColors.black,
                                      onPressed: cubit.registerUser,
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
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryYellow),
        ),
        Expanded(
          child: Center(
            child: Text(
              l10n.register,
              style: const TextStyle(
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
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.alreadyHaveAccount,
          style: const TextStyle(color: AppColors.textWhite),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, AppRoutes.login());
          },
          child: Text(
            l10n.login,
            style: const TextStyle(
              color: AppColors.primaryYellow,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
