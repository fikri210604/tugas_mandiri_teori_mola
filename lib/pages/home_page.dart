import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/home_controller.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController()..init(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Consumer<HomeController>(
              builder: (context, controller, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===================== HEADER =====================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 40,
                          ),
                        ),

                        // Lokasi otomatis dari controller
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              controller.selectedCity,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (controller.isLoading)
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF0A2C6C),
                                  ),
                                ),
                              ),
                            IconButton(
                              icon: const Icon(
                                Icons.refresh,
                                color: Color(0xFF0A2C6C),
                                size: 20,
                              ),
                              tooltip: "Perbarui lokasi",
                              onPressed: controller.refreshLocation,
                            ),
                          ],
                        ),

                        const Icon(
                          Icons.notifications_none,
                          color: Colors.black54,
                          size: 26,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // SEARCH BAR 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Temukan Mobil, Motor, Sepeda, dan lain-lainnya...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // BANNER 
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        bannerCard('assets/images/banner1.png'),
                        bannerCard('assets/images/banner2.png'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===================== KATEGORI
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Kategori",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A2C6C),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 130,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        categoryCard(Icons.directions_car, "Mobil"),
                        const SizedBox(width: 10),
                        categoryCard(Icons.motorcycle, "Motor"),
                        const SizedBox(width: 10),
                        categoryCard(Icons.smartphone, "Handphone"),
                        const SizedBox(width: 10),
                        categoryCard(Icons.laptop, "Laptop"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===================== REKOMENDASI =====================
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Rekomendasi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A2C6C),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: productCard(
                            "Honda CIVIC 1.5L 2020",
                            "Rp 530.000.000",
                            "assets/images/mobil1.png",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: productCard(
                            "Koenigsegg Agera RS 2020",
                            "Rp 1.350.000.000",
                            "assets/images/mobil2.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===================== COMPONENTS =====================

  static Widget bannerCard(String imagePath) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Widget categoryCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: const Color(0xFF0A2C6C)),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF0A2C6C),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static Widget productCard(String title, String price, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar produk
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            price,
            style: const TextStyle(
              color: Color(0xFF0A2C6C),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey, size: 14),
              SizedBox(width: 4),
              Text(
                "Rajabasa, Bandar L",
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
