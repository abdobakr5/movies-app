import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../profile/presentation/widgets/avatar_selector.dart';
import '../../../profile/presentation/widgets/custom_button.dart';
import '../../../profile/presentation/widgets/custom_text_field.dart';
import '../../../profile/presentation/widgets/language_toggle.dart';
import '../../../profile/presentation/widgets/password_text_field.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

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
                    const SnackBar(
                      content: Text('Account Created Successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pushReplacement(context, AppRoutes.login());
                } else if (state is RegisterFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final cubit = BlocProvider.of<RegisterCubit>(context);

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
                                hintText: 'Name',
                                icon: Icons.badge,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              CustomTextField(
                                controller: cubit.emailController,
                                hintText: 'Email',
                                icon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              PasswordTextField(
                                controller: cubit.passwordController,
                                hintText: 'Password',
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              PasswordTextField(
                                controller: cubit.confirmPasswordController,
                                hintText: 'Confirm Password',
                                validator: (value) {
                                  if (value != cubit.passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              CustomTextField(
                                controller: cubit.phoneController,
                                hintText: 'Phone Number',
                                icon: Icons.phone,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your phone number';
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
                                text: 'Create Account',
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