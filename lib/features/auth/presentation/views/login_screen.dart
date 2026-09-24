import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../profile/presentation/widgets/custom_button.dart';
import '../../../profile/presentation/widgets/custom_text_field.dart';
import '../../../profile/presentation/widgets/language_toggle.dart';

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
                    onTap: () {
                      Navigator.push(context, AppRoutes.forgetPassword());
                    },
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
                    if (_formKey.currentState!.validate()) {
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: 
                      _emailController.text, password: _passwordController.text);
                       Navigator.push(context, AppRoutes.updateProfile());
                    }
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
                      onTap: () {
                        Navigator.push(context, AppRoutes.register());
                      },
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

                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.primaryYellow)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Text('OR', style: TextStyle(color: AppColors.primaryYellow)),
                    ),
                    const Expanded(child: Divider(color: AppColors.primaryYellow)),
                  ],
                ),

                const SizedBox(height: 28),
                CustomButton(
                  text: 'Login With Google',
                  onPressed: () {},
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
        ),
      ),
    );
  }
}
