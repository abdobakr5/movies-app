import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/app_routes/app_routes.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_validator.dart';
import 'package:movies_app/features/auth/presentation/cubit/register_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/register_state.dart';
import 'package:movies_app/features/profile/presentation/widgets/avatar_selector.dart';
import 'package:movies_app/features/profile/presentation/widgets/custom_button.dart';
import 'package:movies_app/features/profile/presentation/widgets/custom_text_field.dart';
import 'package:movies_app/features/profile/presentation/widgets/language_toggle.dart';
import 'package:movies_app/features/profile/presentation/widgets/password_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        key: _formKey,
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
                              controller: _nameController,
                              hintText: 'Name',
                              icon: Icons.badge,
                              validator: AppValidator.validateName,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: AppValidator.validateEmail,
                            ),
                            const SizedBox(height: 16),
                            PasswordTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              validator: AppValidator.validatePassword,
                            ),
                            const SizedBox(height: 16),
                            PasswordTextField(
                              controller: _confirmPasswordController,
                              hintText: 'Confirm Password',
                              validator: (value) =>
                                  AppValidator.validateConfirmPassword(
                                      value, _passwordController.text),
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: _phoneController,
                              hintText: 'Phone Number',
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              validator: AppValidator.validatePhone,
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.registerUser(
                                    name: _nameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    phone: _phoneController.text.trim(),
                                  );
                                }
                              },
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