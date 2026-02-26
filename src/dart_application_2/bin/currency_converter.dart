// =============================================================
// Tugas 2: Kalkulator Konversi Mata Uang (Min. 3 Jenis Mata Uang)
// =============================================================
// Mata uang yang didukung: IDR, USD, EUR, GBP, JPY, SGD
// Kurs relatif terhadap IDR (Rupiah) sebagai basis
// =============================================================

import 'dart:io';

void main() {
  print('');
  print('     KALKULATOR KONVERSI MATA UANG      ');
  print('');

  // Map kurs: nilai 1 unit mata uang dalam IDR (13 April 2020)
  final Map<String, double> kursKeIDR = {
    'IDR': 1.0,
    'USD': 15650.0, // 1 USD = 15,650 IDR
    'EUR': 17200.0, // 1 EUR = 17,200 IDR
    'GBP': 20100.0, // 1 GBP = 20,100 IDR
    'JPY': 105.0, // 1 JPY = 105 IDR
    'SGD': 11800.0, // 1 SGD = 11,800 IDR
  };

  // Nama lengkap mata uang untuk tampilan
  final Map<String, String> namaMataUang = {
    'IDR': 'Indonesian Rupiah',
    'USD': 'US Dollar',
    'EUR': 'Euro',
    'GBP': 'British Pound',
    'JPY': 'Japanese Yen',
    'SGD': 'Singapore Dollar',
  };

  bool lanjut = true;

  while (lanjut) {
    print('\n Mata uang yang tersedia:');
    int i = 1;
    for (var kode in kursKeIDR.keys) {
      print('  $i. $kode - ${namaMataUang[kode]}');
      i++;
    }

    // Pilih mata uang asal
    String dariMataUang = pilihMataUang(
      '\nMasukkan kode mata uang ASAL (contoh: USD): ',
      kursKeIDR,
    );

    // Pilih mata uang tujuan
    String keMataUang = pilihMataUang(
      'Masukkan kode mata uang TUJUAN (contoh: IDR): ',
      kursKeIDR,
    );

    // Input jumlah
    stdout.write('Masukkan jumlah yang ingin dikonversi: ');
    double jumlah = inputAngkaPositif();

    // Hitung konversi
    double hasil = konversiMataUang(
      jumlah,
      dariMataUang,
      keMataUang,
      kursKeIDR,
    );

    // Tampilkan hasil
    print('');
    print('               HASIL KONVERSI                 ');
    print(' ${formatMataUang(jumlah, dariMataUang)}');
    print(' = ${formatMataUang(hasil, keMataUang)}');
    print('');
    print(
      ' Kurs: 1 $dariMataUang = ${(kursKeIDR[dariMataUang]! / kursKeIDR[keMataUang]!).toStringAsFixed(4)} $keMataUang',
    );

    // Tanya apakah ingin konversi lagi
    stdout.write('\nKonversi lagi? (y/n): ');
    String? jawaban = stdin.readLineSync()?.toLowerCase();
    lanjut = (jawaban == 'y' || jawaban == 'ya');
  }

  print('\nTerima kasih telah menggunakan Kalkulator Mata Uang! ');
}

/// Menghitung hasil konversi mata uang menggunakan IDR sebagai perantara
double konversiMataUang(
  double jumlah,
  String dari,
  String ke,
  Map<String, double> kurs,
) {
  // Konversi ke IDR terlebih dahulu, lalu ke mata uang tujuan
  double nilaiIDR = jumlah * kurs[dari]!;
  double hasilKonversi = nilaiIDR / kurs[ke]!;
  return hasilKonversi;
}

/// Format tampilan mata uang sesuai konvensi
String formatMataUang(double nilai, String kode) {
  String nilaiFormatted;
  if (kode == 'IDR') {
    // Rupiah: tanpa desimal, format ribuan
    nilaiFormatted = 'Rp ${formatRibuan(nilai.round())}';
  } else if (kode == 'JPY') {
    nilaiFormatted = '¥ ${formatRibuan(nilai.round())}';
  } else {
    nilaiFormatted = '$kode ${nilai.toStringAsFixed(2)}';
  }
  return nilaiFormatted;
}

/// Format angka dengan pemisah ribuan
String formatRibuan(int angka) {
  String str = angka.toString();
  String hasil = '';
  int hitung = 0;
  for (int i = str.length - 1; i >= 0; i--) {
    if (hitung > 0 && hitung % 3 == 0) hasil = '.' + hasil;
    hasil = str[i] + hasil;
    hitung++;
  }
  return hasil;
}

/// Memilih mata uang yang valid dari input pengguna
String pilihMataUang(String prompt, Map<String, double> kurs) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync()?.toUpperCase().trim();
    if (input != null && kurs.containsKey(input)) {
      return input;
    }
    print(' Kode mata uang tidak dikenal. Gunakan kode dari daftar di atas.');
  }
}

/// Input angka positif dengan validasi
double inputAngkaPositif() {
  while (true) {
    String? input = stdin.readLineSync();
    if (input != null) {
      double? nilai = double.tryParse(input.replaceAll(',', '.'));
      if (nilai != null && nilai > 0) return nilai;
    }
    stdout.write(' Masukkan angka positif yang valid: ');
  }
}
