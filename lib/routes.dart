import 'package:flutter/material.dart';
import 'assets/splash_screen.dart';
import 'pages/welcome_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'assets/navigation_bar.dart'; 

class AppRoutes {
  // Definisikan semua nama route di satu tempat
  static const splash = '/splash';
  static const welcome = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const main = '/main';
  static const home = '/home';
  static const profile = '/profile';

  // Daftar mapping antara route dan widget-nya
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    welcome: (context) => const WelcomePage(),
    login: (context) => const LoginPage(),
    signup: (context) => const SignupPage(),
    main: (context) => const CustomNavigation(),
    home: (context) => const HomePage(),
    profile: (context) => const ProfilePage(),
  };
}
