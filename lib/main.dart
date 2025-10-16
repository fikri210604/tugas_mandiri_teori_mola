import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/home_controller.dart';
import 'controllers/profile_controller.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OtoLink',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A2C6C)),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}
