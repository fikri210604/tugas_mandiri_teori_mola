import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class LoginController {
  final BuildContext context;

  // Controller untuk field input
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginController(this.context);

  // 🔹 Validasi input login
  bool validateInputs() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage("⚠️ Harap isi semua field!");
      return false;
    }

    if (!email.contains("@") || !email.contains(".")) {
      _showMessage("📧 Format email tidak valid!");
      return false;
    }

    if (password.length < 8) {
      _showMessage("🔒 Password minimal 8 karakter!");
      return false;
    }

    return true;
  }

  // 🔹 Tampilkan snackbar pesan error/info
  void _showMessage(String msg) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // 🔹 Fungsi submit login
  void submitLogin() {
    if (validateInputs()) {
      // Di sini bisa ditambah autentikasi ke API atau database
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  // 🔹 Bersihkan controller agar tidak ada memory leak
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
