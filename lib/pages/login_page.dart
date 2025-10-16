import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController controller;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    controller = LoginController(context);
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
          "Login",
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
              "Selamat Datang Kembali 👋",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A2C6C),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Masuk untuk melanjutkan ke akun Anda",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 28),

            // EMAIL
            _buildLabel("Email"),
            _buildTextField(
              controller.emailController,
              hint: "Masukkan Email Anda",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // PASSWORD
            _buildLabel("Kata Sandi"),
            _buildPasswordField(controller.passwordController),
            const SizedBox(height: 5),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Lupa Kata Sandi?",
                style: TextStyle(
                  color: Color(0xFF0A2C6C),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // BUTTON LOGIN
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
                onPressed: controller.submitLogin,
                child: const Text(
                  "Masuk",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // NAVIGASI KE SIGNUP
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Belum punya akun? ",
                    style: TextStyle(color: Colors.grey)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    "Daftar Sekarang",
                    style: TextStyle(
                      color: Color(0xFF0A2C6C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget Reusable
  // ============================
  Widget _buildLabel(String text) => Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF0A2C6C),
          fontSize: 13,
        ),
      );

// Widget untuk membuat TextField
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF0A2C6C)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Color(0xFF0A2C6C), width: 1.5),
        ),
      ),
    );
  }

// Widget untuk membuat PasswordField
  Widget _buildPasswordField(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: "Masukkan Kata Sandi Anda",
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() => _obscurePassword = !_obscurePassword);
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF0A2C6C)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Color(0xFF0A2C6C), width: 1.5),
        ),
      ),
    );
  }
}
