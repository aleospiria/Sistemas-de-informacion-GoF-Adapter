import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/before_screen.dart';
import 'screens/after_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patron Adapter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/before': (context) => const BeforeScreen(),
        '/after': (context) => const AfterScreen(),
      },
    );
  }
}
