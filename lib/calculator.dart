import 'package:bmr_calculator/constants.dart';

class Calculator {
  // Menerima data dari Input Page
  Calculator({
    required this.height,
    required this.weight,
    required this.gender,
    required this.age,
    required this.method,
    this.bodyFat = 20,
  });

  final int height;
  final int weight;
  final int age;
  final Gender gender;
  final BMRMethod method;
  final int bodyFat;
  double _bmr = 0;

  // Fungsi utama untuk menghitung BMR berdasarkan metode yang dipilih
  String calculateBMR() {
    if (method == BMRMethod.mifflin) {
      // RUMUS 1: Mifflin-St Jeor
      if (gender == Gender.male) {
        _bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
      } else {
        _bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
      }
    } else if (method == BMRMethod.harris) {
      // RUMUS 2: Revised Harris-Benedict
      if (gender == Gender.male) {
        _bmr = (13.397 * weight) + (4.799 * height) - (5.677 * age) + 88.362;
      } else {
        _bmr = (9.247 * weight) + (3.098 * height) - (4.330 * age) + 447.593;
      }
    } else if (method == BMRMethod.katch) {
      // RUMUS 3: Katch-McArdle
      // LBM dihitung dari berat badan dikurangi estimasi lemak
      double lbm = weight * (1 - (bodyFat / 100));
      _bmr = 370 + (21.6 * lbm);
    }

    return _bmr.toStringAsFixed(0);
  }

  // Memberikan teks nama metode yang digunakan untuk ditampilkan di halaman hasil
  String getResult() {
    if (method == BMRMethod.mifflin) return 'Mifflin-St Jeor';
    if (method == BMRMethod.harris) return 'Harris-Benedict';
    return 'Katch-McArdle';
  }

  // Memberikan penjelasan singkat tentang hasil BMR
  String getInterpretation() {
    return 'Hasil ini menunjukkan jumlah kalori minimum yang dibutuhkan tubuh Anda saat beristirahat total.';
  }
}
