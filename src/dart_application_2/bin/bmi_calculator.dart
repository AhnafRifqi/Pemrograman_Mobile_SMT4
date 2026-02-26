// =============================================================
// Tugas 1: Program Dart untuk Menghitung BMI (Body Mass Index)
// =============================================================
// BMI = Berat (kg) / (Tinggi (m) * Tinggi (m))
// Kategori: Underweight < 18.5 | Normal 18.5-24.9 | Overweight 25-29.9 | Obese >= 30
// =============================================================

import 'dart:io';

void main() {
  print('');
  print('   KALKULATOR BMI (Body Mass Index) ');
  print('');

  // Input berat badan
  double berat = inputAngka('Masukkan berat badan Anda (kg): ', minValue: 1.0);

  // Input tinggi badan
  double tinggi = inputAngka(
    'Masukkan tinggi badan Anda (cm): ',
    minValue: 50.0,
  );

  // Konversi tinggi dari cm ke meter
  double tinggiMeter = tinggi / 100;

  // Hitung BMI
  double bmi = hitungBMI(berat, tinggiMeter);

  // Tentukan kategori BMI
  String kategori = kategoriBMI(bmi);
  String saran = saranKesehatan(bmi);

  // Tampilkan hasil
  print('');
  print('          HASIL PERHITUNGAN         ');
  print(' Berat Badan  : ${berat.toStringAsFixed(1)} kg'.padRight(38) + '');
  print(' Tinggi Badan : ${tinggi.toStringAsFixed(1)} cm'.padRight(38) + '');
  print(' BMI          : ${bmi.toStringAsFixed(2)}'.padRight(38) + '');
  print(' Kategori     : $kategori'.padRight(38) + '');
  print(' Saran        : $saran'.padRight(38) + '');

  // Tabel referensi BMI
  print('');
  print('Referensi Kategori BMI:');
  print('');
  print('  < 18.5  → Berat Badan Kurang (Underweight)');
  print('  18.5–24.9 → Berat Badan Normal');
  print('  25.0–29.9 → Berat Badan Lebih (Overweight)');
  print('  ≥ 30.0  → Obesitas');
  print('');
}

/// Menghitung nilai BMI berdasarkan berat (kg) dan tinggi (meter)
double hitungBMI(double beratKg, double tinggiMeter) {
  return beratKg / (tinggiMeter * tinggiMeter);
}

/// Menentukan kategori berdasarkan nilai BMI
String kategoriBMI(double bmi) {
  if (bmi < 18.5) {
    return 'Underweight (Kurang)';
  } else if (bmi < 25.0) {
    return 'Normal';
  } else if (bmi < 30.0) {
    return 'Overweight (Lebih)';
  } else {
    return 'Obesitas';
  }
}

/// Memberikan saran kesehatan berdasarkan BMI
String saranKesehatan(double bmi) {
  if (bmi < 18.5) {
    return 'Tingkatkan asupan kalori & nutrisi.';
  } else if (bmi < 25.0) {
    return 'Pertahankan gaya hidup sehat Anda!';
  } else if (bmi < 30.0) {
    return 'Perbanyak olahraga & kurangi kalori.';
  } else {
    return 'Konsultasikan dengan dokter segera.';
  }
}

/// Fungsi helper untuk input angka dengan validasi
double inputAngka(String prompt, {double minValue = 0.0}) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();

    if (input != null && input.isNotEmpty) {
      double? nilai = double.tryParse(input);
      if (nilai != null && nilai >= minValue) {
        return nilai;
      }
    }
    print(' Input tidak valid! Masukkan angka positif (minimal $minValue).');
  }
}
