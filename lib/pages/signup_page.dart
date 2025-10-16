import 'package:flutter/material.dart';
import '../controllers/signup_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late SignupController controller;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    controller = SignupController(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.8,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0A2C6C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Color(0xFF0A2C6C),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Silahkan Isi data diri Anda",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A2C6C),
              ),
            ),
            const SizedBox(height: 28),

            // Form Email
            _buildLabel("Email"),
            _buildTextField(
              controller.emailController,
              hint: "Masukkan Email Anda",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Form Password
            _buildLabel("Masukkan Kata Sandi"),
            _buildPasswordField(
              controller.passwordController,
              _obscurePassword,
              () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            const SizedBox(height: 5),
            const Text(
              "*Minimal 8 karakter. Harus menyertakan kombinasi angka, huruf dan karakter",
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Form Konfirmasi Password
            _buildLabel("Konfirmasi Kata Sandi"),
            _buildPasswordField(
              controller.confirmPasswordController,
              _obscureConfirmPassword,
              () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "*Harus menyertakan kombinasi angka, huruf dan karakter",
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Form Username
            _buildLabel("Masukkan Username"),
            _buildTextField(
              controller.usernameController,
              hint: "Masukkan Username Anda",
            ),
            const SizedBox(height: 5),
            const Text(
              "*Harus menyertakan kombinasi angka, huruf dan karakter",
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Lanjut
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A2C6C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: controller.submitSignup,
                child: const Text(
                  "Lanjut",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Komponen UI Reusable

  Widget _buildLabel(String text) => Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.w600,
      color: Color(0xFF0A2C6C),
      fontSize: 13,
    ),
  );

  // Widget untuk mengisi teks (Username & email)
  Widget _buildTextField(
    TextEditingController controller, {
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF0A2C6C)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF0A2C6C), width: 1.5),
        ),
      ),
    );
  }

  // Widget untuk mengisi password
  Widget _buildPasswordField(
    TextEditingController controller,
    bool obscure,
    VoidCallback toggleVisibility,
  ) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: "Masukkan Kata Sandi Anda",
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF0A2C6C)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF0A2C6C), width: 1.5),
        ),
      ),
    );
  }
}
