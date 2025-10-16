import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../pages/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  double progressValue = 0.0;

  @override
  void initState() {
    super.initState();

    //Controller untuk animasi progress bar
    _progressController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..addListener(() {
            setState(() {
              progressValue = _progressController.value;
            });
          });

    _progressController.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return; 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/loading.json',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 30),

            //Linear Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progressValue,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade300,
                  color: const Color(0xFF0A2C6C),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Memuat data...",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0A2C6C),
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
