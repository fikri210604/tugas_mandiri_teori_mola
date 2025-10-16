import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../assets/navigation_bar.dart';

class SignupController {
  final BuildContext context;

  // Controller untuk input form
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  SignupController(this.context);

  // Validasi Input Form
  bool _validateInputs() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = confirmPasswordController.text;
    final username = usernameController.text.trim();

    if ([email, password, confirm, username].any((v) => v.isEmpty)) {
      _showMessage("⚠️ Harap isi semua field!");
      return false;
    }

    if (!_isValidEmail(email)) {
      _showMessage("📧 Format email tidak valid!");
      return false;
    }

    if (password.length < 8) {
      _showMessage("🔒 Password minimal 8 karakter!");
      return false;
    }

    if (password != confirm) {
      _showMessage("❌ Konfirmasi password tidak cocok!");
      return false;
    }

    return true;
  }

  bool _isValidEmail(String email) =>
      email.contains("@") && email.contains(".");

  // Simpan Data User ke SharedPreferences (Dummy JSON)
  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final userData = {
      "user_name": usernameController.text.trim(),
      "user_email": emailController.text.trim(),
      "user_password": passwordController.text.trim(),
    };

    // Simpan dalam format JSON
    await prefs.setString('user_data', jsonEncode(userData));
    await prefs.setString('user_name', userData["user_name"]!);
    await prefs.setString('user_email', userData["user_email"]!);
  }

  // 🔹 Submit Signup
  Future<void> submitSignup() async {
    if (!_validateInputs()) return;

    await _saveUserData();

    if (!context.mounted) return;
    _showMessage("✅ Pendaftaran berhasil!", color: Colors.green);

    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return; 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const CustomNavigation()),
    );
  }

  // Snackbar Utility (Notifikasi Pesan)
  void _showMessage(String msg, {Color color = Colors.redAccent}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
  }
}
