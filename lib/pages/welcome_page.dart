import 'package:flutter/material.dart';
import '../routes.dart'; // gunakan routes agar konsisten

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 Lengkungan atas
              RepaintBoundary(
                child: ClipPath(
                  clipper: TopCurveClipper(),
                  child: Container(
                    height: size.height * 0.15,
                    color: const Color(0xFF0A2C6C),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 🔹 Logo Aplikasi
              Image.asset(
                'assets/images/logo.png',
                width: size.width * 0.45,
                height: size.width * 0.45,
              ),

              const SizedBox(height: 16),

              const Text(
                "OtoLink",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A2C6C),
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Pusatnya Ngedeal Kendaraan Bermotor!",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              const Text(
                "Selamat Datang di Otolink!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A2C6C),
                ),
              ),

              const SizedBox(height: 24),

              // 🔹 Tombol Login
              _buildButton(
                context,
                icon: Icons.login_rounded,
                label: "Login / Masuk",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),

              const SizedBox(height: 12),

              // 🔹 Tombol SignUp
              _buildButton(
                context,
                icon: Icons.person_add_alt_1,
                label: "Sign Up / Daftar",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
              ),

              const SizedBox(height: 30),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Dengan masuk, Anda menyetujui\n"
                  "Syarat, Ketentuan & Kebijakan Privasi OtoLink",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Fungsi tombol reusable
  Widget _buildButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: const Color(0xFF0A2C6C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}

// 🔹 Lengkungan atas
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
