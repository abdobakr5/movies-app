import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// --------------------------------- Colors -----------------------------------------
const Color kBackgroundColor = Color(0xFF1E1E1E);
const Color kYellowColor = Color(0xFFF5C518);
const Color kFieldColor = Color(0xFF2B2B2B);
const Color kHintColor = Color(0xFF9A9A9A);


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}
class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {


  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

// --------------------------------- Dispose ---------------------------------

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),

                buildImage(),

                const SizedBox(height: 50),

                buildEmailField(),

                const SizedBox(height: 16),

                buildVerifyButton(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // --------------------------------------------- App Bar -----------------------------------------
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: kYellowColor),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Forget Password',
        style: TextStyle(
          color: kYellowColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ---------------------------------------- Image -------------------------------------
  Widget buildImage() {
    return Image.asset(
      'assets/Forgot password-bro 1.png',
      height: 450,
      fit: BoxFit.contain,
    );
  }

  // ---------------------------------------- Email Field ----------------------------------------

  Widget buildEmailField() {
    return TextFormField(
      controller: _emailController,

      keyboardType: TextInputType.emailAddress,

      textInputAction: TextInputAction.done,

      cursorColor: kYellowColor,

      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your email';
        }

        final emailRegex = RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        );

        if (!emailRegex.hasMatch(value.trim())) {
          return 'Please enter a valid email';
        }

        return null;
      },

      decoration: InputDecoration(
        hintText: 'Email',

        hintStyle: const TextStyle(
          color: kHintColor,
          fontSize: 15,
        ),

        filled: true,

        fillColor: kFieldColor,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
        ),

        prefixIcon: buildEmailIcon(),

        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: kYellowColor,
            width: 1,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget buildEmailIcon() {
    return Container(
      width: 34,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.email, size: 18, color: kBackgroundColor),
    );
  }

  // ----------------------------------------- Verify Button -------------------------------------
  Widget buildVerifyButton() {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _sendResetEmail,
        style: ElevatedButton.styleFrom(
          backgroundColor: kYellowColor,
          disabledBackgroundColor:
          kYellowColor.withOpacity(0.6),
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: Colors.black,
          ),
        )
            : const Text(
          'Verify Email',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


// --------------------------------- Firebase Logic ---------------------------------

  Future<void> _sendResetEmail() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      // Send password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password reset email sent! Check your inbox.',
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Optional: go back after successful request
      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (!mounted) return;

      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      String message;

      switch (e.code) {
        case 'invalid-email':
          message = 'The email address is invalid.';
          break;

        case 'user-not-found':
          message = 'No account was found with this email.';
          break;

        case 'network-request-failed':
          message = 'Please check your internet connection.';
          break;

        case 'too-many-requests':
          message =
          'Too many requests. Please try again later.';
          break;

        default:
          message =
              e.message ?? 'Something went wrong. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );

    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong. Please try again.',
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}