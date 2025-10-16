import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({super.key});

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  int _currentPageIndex = 0;

  // Daftar halaman yang akan ditampilkan
  final List<Widget> _pages = const [
    HomePage(),
    Center(child: Text('Chat Page')),
    Center(child: Text('Favorite Page')),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Gunakan IndexedStack agar halaman tidak rebuild saat pindah tab
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pages,
      ),

      // 🔹 Navigation Bar Bawah
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xFF0A2C6C).withOpacity(0.1),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          height: 70,
          backgroundColor: Colors.white,
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: Color(0xFF0A2C6C)),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.chat, color: Color(0xFF0A2C6C)),
              icon: Icon(Icons.chat_outlined),
              label: 'Chat',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite, color: Color(0xFF0A2C6C)),
              icon: Icon(Icons.favorite_outline),
              label: 'Favorite',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person, color: Color(0xFF0A2C6C)),
              icon: Icon(Icons.person_outline),
              label: 'Akun Saya',
            ),
          ],
        ),
      ),
    );
  }
}
