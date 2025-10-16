# 🚗 **OtoLink — Aplikasi Marketplace Kendaraan Bermotor dan Elektronik**
> Tugas Mandiri MOLA — Universitas Lampung (2025)

![Flutter](https://img.shields.io/badge/Flutter-3.9.0-blue?logo=flutter)
![License](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-lightgrey)
![Status](https://img.shields.io/badge/status-Development-orange)

---

## 📘 **Deskripsi Proyek**

**OtoLink** adalah aplikasi marketplace kendaraan bermotor dan elektronik berbasis **Flutter** yang dikembangkan untuk memenuhi tugas mandiri mata kuliah **Mobile Programming (MOLA)**.  
Aplikasi ini memungkinkan pengguna untuk **mendaftar akun (Sign Up)**, **login menggunakan akun JSON maupun lokal**, **mendeteksi lokasi pengguna**, serta **mengelola profil akun** dengan tampilan modern dan responsif.

---

## ✨ **Fitur Utama**

| Fitur | Deskripsi |
|-------|------------|
| 🧭 **Splash Screen Animasi** | Animasi loading menggunakan Lottie + progress bar linear |
| 👋 **Welcome Page** | Tampilan awal dengan tombol login dan signup |
| 🔐 **Login Ganda** | Mendukung login via *dummy JSON file* dan *SharedPreferences* |
| 🧾 **Signup Lokal** | Menyimpan akun baru ke `SharedPreferences` (tanpa database) |
| 🌍 **Home Page dengan Geolocator** | Menampilkan lokasi pengguna otomatis berdasarkan GPS dan menampilkan barang sesuai lokasi pengguna |
| 👤 **Profile Page Dinamis** | Menampilkan nama & email pengguna dari session yang tersimpan |
| 🔁 **Persistent Session** | User tetap login meski aplikasi ditutup |
| 🚪 **Logout Aman** | Menghapus flag login tanpa menghapus data user |
| 🧭 **Bottom Navigation Bar** | Navigasi cepat ke halaman Home, Chat, Favorite, dan Akun Saya |

---


---

## 🧠 **Penjelasan Controller**

### 🔹 `home_controller.dart`
- Mengelola deteksi lokasi perangkat menggunakan `Geolocator`.
- Mengambil nama kota dari koordinat menggunakan `Geocoding`.
- Menyediakan fungsi `refreshLocation()` untuk update manual lokasi.

### 🔹 `login_controller.dart`
- Memvalidasi input email & password.
- Mengecek akun dari **SharedPreferences** terlebih dahulu, lalu dari `dummyAccount.json`.
- Jika valid → menyimpan session (`is_logged_in = true`) & navigasi ke halaman utama (`CustomNavigation()`).

### 🔹 `signup_controller.dart`
- Melakukan validasi input form (email, password, konfirmasi password, username).
- Menyimpan data user baru ke `SharedPreferences` dalam format JSON.
- Menampilkan notifikasi melalui `SnackBar`.

### 🔹 `profile_controller.dart`
- Mengambil dan menampilkan data `user_name` & `user_email` dari `SharedPreferences`.
- Menyediakan fungsi `logout()` yang mengubah `is_logged_in` ke `false` tanpa menghapus data user.

---

## 🖥️ **Penjelasan Halaman (UI Pages)**

| Halaman | Deskripsi |
|----------|------------|
| `SplashScreen` | Animasi pembuka aplikasi dengan Lottie dan progress bar |
| `WelcomePage` | Halaman pembuka berisi tombol login & signup |
| `LoginPage` | Form login (cek dari dummy JSON atau SharedPreferences) |
| `SignupPage` | Form pendaftaran akun baru (disimpan lokal) |
| `HomePage` | Menampilkan lokasi pengguna dan konten utama aplikasi |
| `ProfilePage` | Menampilkan nama, email, serta menu profil dan logout |

---

## ⚙️ **Cara Setup dan Menjalankan Proyek**

### 1️⃣ Clone Repository
```bash
git clone https://github.com/username/tugasmandiri_mola_2317051061.git
cd tugasmandiri_mola_2317051061
```
### 2️⃣ Install Dependency
```bash
flutter pub get
```
### 3️⃣ Menjalankan APK
```bash
flutter run
```



