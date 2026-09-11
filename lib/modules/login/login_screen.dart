import 'package:flutter/material.dart';
import 'package:movies_app/core/app_assets/app_assets.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/widgets/custom_buttom.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';
import 'package:movies_app/modules/login/language_switch.dart';
import 'package:movies_app/modules/login/on_divider_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordHidden = true;
  final bool _isEnglish = true;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
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
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 22),

                // ───── Password ─────
                CustomTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: _isPasswordHidden,
                  textInputAction: TextInputAction.done,
                  validator: _validatePassword,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _isPasswordHidden = !_isPasswordHidden),
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    // onTap: _onForgetPasswordPressed,
                    child: const Text(
                      'Forget Password ?',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    // implement login logic here
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => const HomeScreen()),
                    // );
                  },
                ),
                const SizedBox(height: 22),

                // ───── Don't Have Account ? Create One ─────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Have Account ? ",
                      style: TextStyle(color: AppColors.white, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Create One',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                const OnDividerWidget(),
                const SizedBox(height: 28),
                CustomButton(
                  text: 'Login With Google',
                  onPressed: () {},
                  iconPath: AppAssets.google,
                ),
                const SizedBox(height: 32),

                LanguageSwitch(isEnglish: _isEnglish, onChanged: (value) {}),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
