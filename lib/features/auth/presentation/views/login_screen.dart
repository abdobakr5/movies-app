import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/app_routes/app_routes.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/login_state.dart';
import 'package:movies_app/features/profile/presentation/widgets/custom_button.dart';
import 'package:movies_app/features/profile/presentation/widgets/custom_text_field.dart';
import 'package:movies_app/features/profile/presentation/widgets/language_toggle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordHidden = true;

  void _handleState(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      Navigator.pushReplacement(context, AppRoutes.mainLayout());
    } else if (state is PasswordResetEmailSent) {
      _showMessage(
        context,
        '${AppLocalizations.of(context)!.passwordResetEmailSent} ${state.email}',
        AppColors.primary,
      );
    } else if (state is LoginFailure) {
      _showMessage(context, state.errorMessage, AppColors.red);
    }
  }

  void _showMessage(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), backgroundColor: color),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: _handleState,
          builder: (context, state) {
            final LoginCubit cubit = context.read<LoginCubit>();
            final bool isLoading = state is LoginLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 50),
                    Center(
                      child: Image.asset(
                        AppAssets.appLogo,
                        height: 118,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 70),
                    CustomTextField(
                      controller: cubit.emailController,
                      hintText: l10n.email,
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: cubit.validateEmail,
                    ),
                    const SizedBox(height: 22),
                    CustomTextField(
                      controller: cubit.passwordController,
                      hintText: l10n.password,
                      prefixIcon: Icons.lock,
                      obscureText: _isPasswordHidden,
                      textInputAction: TextInputAction.done,
                      validator: cubit.validatePassword,
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () => _isPasswordHidden = !_isPasswordHidden,
                        ),
                        icon: Icon(
                          _isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryYellow,
                        ),
                      )
                    else
                      CustomButton(
                        text: l10n.login,
                        onPressed: cubit.loginWithEmail,
                      ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.dontHaveAccount,
                          style:
                              const TextStyle(color: AppColors.white, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: isLoading
                              ? null
                              : () => Navigator.push(
                                    context,
                                    AppRoutes.register(),
                                  ),
                          child: Text(
                            l10n.createOne,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(color: AppColors.primaryYellow)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            l10n.or,
                            style: const TextStyle(color: AppColors.primaryYellow),
                          ),
                        ),
                        const Expanded(
                            child: Divider(color: AppColors.primaryYellow)),
                      ],
                    ),
                    const SizedBox(height: 28),
                    CustomButton(
                      text: l10n.loginWithGoogle,
                      onPressed: isLoading ? () {} : cubit.loginWithGoogle,
                      iconPath: AppAssets.google,
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: LanguageToggleButton(
                        leftFlagPath: AppAssets.flagLeft,
                        rightFlagPath: AppAssets.flagRight,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
