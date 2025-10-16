import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeController with ChangeNotifier {
  String selectedCity = "Mendeteksi lokasi...";

  bool isLoading = true;
  Future<void> init() async {
    // Jalankan setelah frame pertama selesai digambar
    Future.microtask(() async {
      await _determinePosition();
    });
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _updateCity("Layanan lokasi nonaktif", false);
        return;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _updateCity("Izin lokasi ditolak", false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _updateCity("Izin lokasi permanen ditolak", false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
        ),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;

      String city =
          place.subAdministrativeArea ??
          place.locality ??
          place.administrativeArea ??
          "Tidak diketahui";

      _updateCity(city, false);
    } catch (e) {
      debugPrint("Error mendeteksi lokasi: $e");
      _updateCity("Gagal mendeteksi lokasi", false);
    }
  }

  // Fungsi untuk Update nama kota + status loading
  void _updateCity(String city, bool loading) {
    selectedCity = city;
    isLoading = loading;
    notifyListeners();
  }

  // Fungsi publik untuk refresh lokasi manual (misal lewat tombol)
  Future<void> refreshLocation() async {
    _updateCity("Mendeteksi lokasi...", true); 
    await _determinePosition(); 
  }
}
