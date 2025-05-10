import 'package:animation_app/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF6200EE),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF6200EE),
          secondary: Color(0xFF03DAC6),
          tertiary: Color(0xFFFF7597),
          background: Color(0xFFFAFAFA),
        ),
        fontFamily: 'Poppins',
      ),
      home: HomeScreen(),
    );
  }
}

