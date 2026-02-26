// =============================================================
// TANTANGAN TAMBAHAN: Aplikasi Konversi Unit
// =============================================================
// Kategori: Panjang, Massa, Volume, Suhu
// Setiap kategori minimal 5 unit
// Validasi input (nilai negatif untuk massa, volume ditolak)
// Menggunakan Map untuk menyimpan faktor konversi
// =============================================================

import 'dart:io';
import 'dart:math';


// MAP FAKTOR KONVERSI
// Semua nilai dikonversi ke/dari satuan dasar (SI) terlebih dahulu


// Panjang: satuan dasar = meter (m)
final Map<String, double> faktorPanjang = {
  'mm': 0.001,        // milimeter
  'cm': 0.01,         // sentimeter
  'm': 1.0,           // meter (dasar)
  'km': 1000.0,       // kilometer
  'in': 0.0254,       // inci
  'ft': 0.3048,       // kaki (feet)
  'yd': 0.9144,       // yard
  'mi': 1609.344,     // mil
};

// Nama lengkap satuan panjang
final Map<String, String> namaPanjang = {
  'mm': 'Milimeter',
  'cm': 'Sentimeter',
  'm': 'Meter',
  'km': 'Kilometer',
  'in': 'Inci (inch)',
  'ft': 'Kaki (feet)',
  'yd': 'Yard',
  'mi': 'Mil (mile)',
};

// Massa: satuan dasar = kilogram (kg)
final Map<String, double> faktorMassa = {
  'mg': 0.000001,     // miligram
  'g': 0.001,         // gram
  'kg': 1.0,          // kilogram (dasar)
  'ton': 1000.0,      // ton metrik
  'lb': 0.453592,     // pon (pound)
  'oz': 0.0283495,    // ons (ounce)
  'ct': 0.0002,       // karat
};

final Map<String, String> namaMassa = {
  'mg': 'Miligram',
  'g': 'Gram',
  'kg': 'Kilogram',
  'ton': 'Ton Metrik',
  'lb': 'Pon (Pound)',
  'oz': 'Ons (Ounce)',
  'ct': 'Karat',
};

// Volume: satuan dasar = liter (L)
final Map<String, double> faktorVolume = {
  'ml': 0.001,        // mililiter
  'cl': 0.01,         // sentiliter
  'dl': 0.1,          // desiliter
  'L': 1.0,           // liter (dasar)
  'm3': 1000.0,       // meter kubik
  'tsp': 0.00492892,  // sendok teh (teaspoon)
  'tbsp': 0.0147868,  // sendok makan (tablespoon)
  'cup': 0.236588,    // cup (US)
  'pt': 0.473176,     // pint (US)
  'gal': 3.78541,     // galon (US)
};

final Map<String, String> namaVolume = {
  'ml': 'Mililiter',
  'cl': 'Sentiliter',
  'dl': 'Desiliter',
  'L': 'Liter',
  'm3': 'Meter Kubik',
  'tsp': 'Sendok Teh',
  'tbsp': 'Sendok Makan',
  'cup': 'Cup (US)',
  'pt': 'Pint (US)',
  'gal': 'Galon (US)',
};

// Suhu: menggunakan fungsi konversi khusus (tidak bisa faktor linier sederhana)
final List<String> satuanSuhu = ['C', 'F', 'K', 'R', 'Re'];
final Map<String, String> namaSuhu = {
  'C': 'Celsius (°C)',
  'F': 'Fahrenheit (°F)',
  'K': 'Kelvin (K)',
  'R': 'Rankine (°R)',
  'Re': 'Réaumur (°Re)',
};


// FUNGSI KONVERSI SUHU


/// Konversi suhu dari satu satuan ke satuan lain
/// Langkah: konversi ke Celsius terlebih dahulu, lalu ke tujuan
double konversiSuhu(double nilai, String dari, String ke) {
  // Langkah 1: Konversi ke Celsius
  double celsius;
  switch (dari) {
    case 'C':
      celsius = nilai;
      break;
    case 'F':
      celsius = (nilai - 32) * 5 / 9;
      break;
    case 'K':
      celsius = nilai - 273.15;
      break;
    case 'R':
      celsius = (nilai - 491.67) * 5 / 9;
      break;
    case 'Re':
      celsius = nilai * 5 / 4;
      break;
    default:
      throw ArgumentError('Satuan suhu tidak dikenal: $dari');
  }

  // Langkah 2: Konversi dari Celsius ke tujuan
  double hasil;
  switch (ke) {
    case 'C':
      hasil = celsius;
      break;
    case 'F':
      hasil = celsius * 9 / 5 + 32;
      break;
    case 'K':
      hasil = celsius + 273.15;
      break;
    case 'R':
      hasil = (celsius + 273.15) * 9 / 5;
      break;
    case 'Re':
      hasil = celsius * 4 / 5;
      break;
    default:
      throw ArgumentError('Satuan suhu tidak dikenal: $ke');
  }

  return hasil;
}

/// Konversi menggunakan faktor perkalian (untuk panjang, massa, volume)
double konversiLinear(
  double nilai,
  String dari,
  String ke,
  Map<String, double> faktor,
) {
  double nilaiBasis = nilai * faktor[dari]!;  // ke satuan dasar
  return nilaiBasis / faktor[ke]!;             // ke satuan tujuan
}


// FUNGSI TAMPILAN


void tampilkanDaftarSatuan(Map<String, String> namaSatuan) {
  int i = 1;
  for (var entry in namaSatuan.entries) {
    print('  ${i.toString().padLeft(2)}. ${entry.key.padRight(6)} → ${entry.value}');
    i++;
  }
}

String pilihSatuan(String prompt, Map<String, String> namaSatuan) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync()?.trim();
    if (input != null && namaSatuan.containsKey(input)) {
      return input;
    }
    print('  Satuan tidak valid. Gunakan kode dari daftar di atas.');
  }
}

String pilihSatuanSuhu(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync()?.trim();
    if (input != null && satuanSuhu.contains(input)) {
      return input;
    }
    print('  Satuan tidak valid. Gunakan kode dari daftar di atas.');
  }
}

/// Input nilai dengan validasi (opsional: larang nilai negatif)
double inputNilai(String prompt, {bool larangNegatif = false}) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync()?.replaceAll(',', '.');
    if (input != null) {
      double? nilai = double.tryParse(input.trim());
      if (nilai != null) {
        if (larangNegatif && nilai < 0) {
          print('  Nilai tidak boleh negatif untuk satuan ini!');
          continue;
        }
        return nilai;
      }
    }
    print('  Input tidak valid. Masukkan angka yang benar.');
  }
}

String formatHasil(double nilai) {
  if (nilai.abs() >= 1e6 || (nilai.abs() < 0.0001 && nilai != 0)) {
    return nilai.toStringAsExponential(4);
  }
  return nilai.toStringAsFixed(4).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
}


// MENU UTAMA


void main() {
  print('');
  print('APLIKASI KONVERSI UNIT');
  print('Kategori: Panjang | Massa | Volume | Suhu');
  print('');

  bool lanjut = true;

  while (lanjut) {
    print(' PILIH KATEGORI KONVERSI:');
    print('  1.  Panjang  (mm, cm, m, km, in, ft, yd, mi)');
    print('  2.  Massa    (mg, g, kg, ton, lb, oz, ct)');
    print('  3.  Volume   (ml, L, m3, cup, gal, ...)');
    print('  4.  Suhu     (°C, °F, K, °R, °Re)');
    print('  0.  Keluar');

    stdout.write('Pilihan (0-4): ');
    String? pilihan = stdin.readLineSync()?.trim();

    switch (pilihan) {
      case '1':
        konversiPanjang();
        break;
      case '2':
        konversiMassa();
        break;
      case '3':
        konversiVolume();
        break;
      case '4':
        konversiSuhuMenu();
        break;
      case '0':
        lanjut = false;
        print(' Terima kasih telah menggunakan Aplikasi Konversi Unit!');
        break;
      default:
        print('  Pilihan tidak valid. Masukkan 0-4.');
    }
  }
}


// SUBMENU KONVERSI

void konversiPanjang() {
  print('  KONVERSI PANJANG ');
  tampilkanDaftarSatuan(namaPanjang);

  String dari = pilihSatuan('Satuan asal   : ', namaPanjang);
  String ke    = pilihSatuan('Satuan tujuan : ', namaPanjang);

  // Panjang tidak boleh negatif secara fisik
  double nilai = inputNilai('Nilai ($dari)  : ', larangNegatif: true);

  double hasil = konversiLinear(nilai, dari, ke, faktorPanjang);

  print(' Hasil:');
  print('   $nilai ${namaPanjang[dari]} = ${formatHasil(hasil)} ${namaPanjang[ke]}');
  tampilkanTabelKonversiPanjang(nilai, dari);
}

void konversiMassa() {
  print('  KONVERSI MASSA ');
  tampilkanDaftarSatuan(namaMassa);

  String dari = pilihSatuan('Satuan asal   : ', namaMassa);
  String ke    = pilihSatuan('Satuan tujuan : ', namaMassa);

  // Massa tidak bisa negatif (fisik)
  double nilai = inputNilai('Nilai ($dari)  : ', larangNegatif: true);

  double hasil = konversiLinear(nilai, dari, ke, faktorMassa);

  print(' Hasil:');
  print('   $nilai ${namaMassa[dari]} = ${formatHasil(hasil)} ${namaMassa[ke]}');
}

void konversiVolume() {
  print('  KONVERSI VOLUME ');
  tampilkanDaftarSatuan(namaVolume);

  String dari = pilihSatuan('Satuan asal   : ', namaVolume);
  String ke    = pilihSatuan('Satuan tujuan : ', namaVolume);

  // Volume tidak bisa negatif (fisik)
  double nilai = inputNilai('Nilai ($dari)  : ', larangNegatif: true);

  double hasil = konversiLinear(nilai, dari, ke, faktorVolume);

  print(' Hasil:');
  print('   $nilai ${namaVolume[dari]} = ${formatHasil(hasil)} ${namaVolume[ke]}');
}

void konversiSuhuMenu() {
  print('   KONVERSI SUHU ');
  print('  Satuan tersedia:');
  for (var s in satuanSuhu) {
    print('    $s  → ${namaSuhu[s]}');
  }

  String dari = pilihSatuanSuhu('Satuan asal   : ');
  String ke    = pilihSatuanSuhu('Satuan tujuan : ');

  // Suhu boleh negatif (misal: -10°C adalah valid)
  double nilai = inputNilai('Nilai ($dari)  : ', larangNegatif: false);

  // Validasi suhu di bawah nol absolut
  double nilaiKelvin = konversiSuhu(nilai, dari, 'K');
  if (nilaiKelvin < 0) {
    print('  Peringatan: Suhu ini berada di bawah nol absolut (0 K = -273.15°C)!');
    print('   Nilai mungkin tidak memiliki makna fisik.');
  }

  double hasil = konversiSuhu(nilai, dari, ke);
  print('');
  print(' Hasil:');
  print('   $nilai ${namaSuhu[dari]} = ${formatHasil(hasil)} ${namaSuhu[ke]}');

  // Tampilkan semua konversi sekaligus
  print('   Tabel lengkap untuk $nilai ${namaSuhu[dari]}:');
  for (var s in satuanSuhu) {
    double h = konversiSuhu(nilai, dari, s);
    print('   → ${s.padRight(3)} : ${formatHasil(h)} ${namaSuhu[s]}');
  }
}

/// Tampilkan tabel konversi ke semua satuan panjang
void tampilkanTabelKonversiPanjang(double nilai, String dariSatuan) {
  print('    Tabel konversi untuk $nilai ${namaPanjang[dariSatuan]}:');
  for (var entry in namaPanjang.entries) {
    double h = konversiLinear(nilai, dariSatuan, entry.key, faktorPanjang);
    print('   → ${entry.key.padRight(5)}: ${formatHasil(h)} ${entry.value}');
  }
}