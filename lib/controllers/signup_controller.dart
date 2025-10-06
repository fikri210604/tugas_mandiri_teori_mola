import 'package:flutter/material.dart';
import '../pages/home_page.dart';

/// 🧭 SignupController
/// Controller ini bertanggung jawab untuk:
/// - Menangani input pengguna saat proses pendaftaran (Sign Up)
/// - Melakukan validasi data (email, password, konfirmasi password, username)
/// - Menampilkan pesan error dengan Snackbar
/// - Navigasi ke halaman HomePage setelah data valid
class SignupController {
  /// Context dibutuhkan untuk melakukan navigasi dan menampilkan snackbar
  final BuildContext context;

  /// Controller untuk setiap input field agar bisa membaca teks yang diinput
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  /// Konstruktor wajib menerima context
  SignupController(this.context);

  // =============================================================
  // 🔹 Fungsi utama: Validasi input pengguna
  // =============================================================
  bool validateInputs() {
    final email = emailController.text.trim(); // hapus spasi di awal/akhir
    final pass = passwordController.text;
    final confirmPass = confirmPasswordController.text;
    final username = usernameController.text.trim();

    // 1️⃣ Pastikan semua field terisi
    if (email.isEmpty || pass.isEmpty || confirmPass.isEmpty || username.isEmpty) {
      _showMessage("⚠️ Harap isi semua field!");
      return false;
    }

    // 2️⃣ Validasi format email (harus ada '@' dan '.')
    if (!email.contains("@") || !email.contains(".")) {
      _showMessage("📧 Format email tidak valid!");
      return false;
    }

    // 3️⃣ Validasi panjang password
    if (pass.length < 8) {
      _showMessage("🔒 Password minimal 8 karakter!");
      return false;
    }

    // 4️⃣ Pastikan konfirmasi password sama
    if (pass != confirmPass) {
      _showMessage("❌ Konfirmasi password tidak cocok!");
      return false;
    }

    // ✅ Semua validasi lolos
    return true;
  }

  // =============================================================
  // 🔹 Fungsi utilitas untuk menampilkan pesan dengan Snackbar
  // =============================================================
  void _showMessage(String msg) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar() // hapus snackbar sebelumnya agar tidak menumpuk
      ..showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Colors.redAccent, // warna merah untuk error
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // =============================================================
  // 🔹 Fungsi submit: jika valid, arahkan ke HomePage
  // =============================================================
  void submitSignup() {
    if (validateInputs()) {
      // Di sini nanti bisa ditambahkan logic simpan data (misal ke Firebase / API)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  // =============================================================
  // 🔹 Bersihkan semua TextEditingController (hindari memory leak)
  // =============================================================
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
  }
}
