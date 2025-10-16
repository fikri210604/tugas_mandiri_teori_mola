import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../assets/navigation_bar.dart';

class LoginController {
  final BuildContext context;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginController(this.context);

  Future<void> submitLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("⚠️ Harap isi semua field!");
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      // Cek dulu dari SharedPreferences (akun hasil signup)

      final savedUserJson = prefs.getString('user_data');
      if (savedUserJson != null) {
        final savedUser = jsonDecode(savedUserJson);
        if (savedUser['user_email'] == email &&
            savedUser['user_password'] == password) {
          await _saveLoginSession(prefs, savedUser['user_name'], savedUser['user_email']);
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CustomNavigation()),
            );
          }
          return;
        }
      }

      // Kalau tidak ada di SharedPreferences, cek ke dummy JSON
      final jsonString = await rootBundle.loadString('assets/data/dummyAccount.json');
      final List<dynamic> accounts = json.decode(jsonString);

      final user = accounts.firstWhere(
        (acc) => acc['email'] == email && acc['password'] == password,
        orElse: () => {},
      );

      if (user.isNotEmpty) {
        await _saveLoginSession(prefs, user['username'], user['email']);
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const CustomNavigation()),
          );
        }
      } else {
        _showMessage("❌ Email atau password salah!");
      }

    } catch (e) {
      _showMessage("Gagal memuat data login: $e");
    }
  }

  //  Simpan session login
  Future<void> _saveLoginSession(
      SharedPreferences prefs, String name, String email) async {
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
  }

  // Tampilkan pesan
  void _showMessage(String msg) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
      );
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
