import 'package:flutter/material.dart';
import 'package:bmr_calculator/pages/input_page.dart'; // Import halaman input

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Mengatur tema gelap untuk seluruh aplikasi
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: InputPage(), // Halaman pertama yang muncul
    );
  }
}