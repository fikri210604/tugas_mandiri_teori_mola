import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController with ChangeNotifier {
  String _userName = "Memuat data...";
  String _userEmail = "";
  bool _isLoading = true;

  String get userName => _userName;
  String get userEmail => _userEmail;
  bool get isLoading => _isLoading;

  ProfileController() {
    loadUser();
  }

  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      _userName = prefs.getString('user_name') ?? "Tidak ditemukan";
      _userEmail = prefs.getString('user_email') ?? "-";
      
    } catch (e) {
      _userName = "Gagal memuat profil";
      _userEmail = "";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }
}
