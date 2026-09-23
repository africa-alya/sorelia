import 'package:flutter/material.dart';

import 'screens/onboarding.dart';


void main() {
  runApp(const SoreliaApp());
}

class SoreliaApp extends StatelessWidget {
  const SoreliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorélia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF162C52),
          primary: const Color(0xFF162C52),
        ),
        useMaterial3: true,
      ),
      home: const OnboardingPage(),
      //home : const NotePage(),
    );
  }
}
