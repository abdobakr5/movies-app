import 'package:flutter/material.dart';

// --------------------------------- Colors -----------------------------------------
const Color kBackgroundColor = Color(0xFF1E1E1E);
const Color kYellowColor = Color(0xFFF5C518);
const Color kFieldColor = Color(0xFF2B2B2B);
const Color kHintColor = Color(0xFF9A9A9A);


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
    return TextField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: kYellowColor,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: const TextStyle(color: kHintColor, fontSize: 15),
        filled: true,
        fillColor: kFieldColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        prefixIcon: buildEmailIcon(),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
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
        onPressed: () {
          // TODO: add your logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kYellowColor,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Verify Email',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}