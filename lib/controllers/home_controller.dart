import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// 🧭 HomeController
/// Controller ini bertugas untuk:
/// - Mengambil lokasi pengguna secara otomatis menggunakan GPS
/// - Melakukan reverse geocoding (mengubah koordinat → nama kota)
/// - Memberi notifikasi ke UI saat lokasi berubah
class HomeController with ChangeNotifier {
  /// Nama kota yang terdeteksi
  String selectedCity = "Mendeteksi lokasi...";

  /// Status loading (true = sedang memproses)
  bool isLoading = true;

  // =============================================================
  // 🔹 Inisialisasi controller (biasanya dipanggil di initState)
  // =============================================================
  Future<void> init() async {
    await _determinePosition(); // langsung deteksi lokasi pengguna
  }

  // =============================================================
  // 🔹 Proses utama: Deteksi lokasi dan ubah jadi nama kota
  // =============================================================
  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // 1️⃣ Periksa apakah layanan lokasi di device aktif
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _updateCity("Layanan lokasi nonaktif", false);
        return;
      }

      // 2️⃣ Cek izin lokasi (permission)
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Jika belum diizinkan → minta izin ke user
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _updateCity("Izin lokasi ditolak", false);
          return;
        }
      }

      // 3️⃣ Jika permission ditolak permanen (tidak bisa diminta lagi)
      if (permission == LocationPermission.deniedForever) {
        _updateCity("Izin lokasi permanen ditolak", false);
        return;
      }

      // 4️⃣ Ambil posisi pengguna (latitude & longitude)
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 5️⃣ Gunakan Geocoding untuk ubah koordinat jadi nama kota
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Ambil data lokasi pertama (biasanya paling akurat)
      Placemark place = placemarks.first;

      // Gunakan field yang tersedia untuk menentukan nama kota
      String city = place.subAdministrativeArea ??
          place.locality ??
          place.administrativeArea ??
          "Tidak diketahui";

      // 6️⃣ Update state dan beri tahu UI
      _updateCity(city, false);
    } catch (e) {
      // Jika ada error (misalnya GPS mati atau koneksi buruk)
      debugPrint("Error mendeteksi lokasi: $e");
      _updateCity("Gagal mendeteksi lokasi", false);
    }
  }

  // =============================================================
  // 🔹 Fungsi internal: Update nama kota + status loading
  // =============================================================
  void _updateCity(String city, bool loading) {
    selectedCity = city;
    isLoading = loading;
    notifyListeners(); // memberi tahu widget UI agar rebuild
  }

  // =============================================================
  // 🔹 Fungsi publik untuk refresh lokasi manual (misal lewat tombol)
  // =============================================================
  Future<void> refreshLocation() async {
    _updateCity("Mendeteksi lokasi...", true); // tampilkan status loading
    await _determinePosition(); // panggil ulang deteksi lokasi
  }
}
