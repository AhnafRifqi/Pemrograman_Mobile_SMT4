// =============================================================
// Tugas 3: Program yang Menerapkan SEMUA Jenis Operator Dart
// =============================================================
// Operator yang dicakup:
//   1. Aritmatika    (+, -, *, /, ~/, %)
//   2. Relasional    (==, !=, >, <, >=, <=)
//   3. Logika        (&&, ||, !)
//   4. Assignment    (=, +=, -=, *=, /=, ~/=, %=)
//   5. Bitwise       (&, |, ^, ~, <<, >>)
//   6. Unary         (++, --, -, +)
//   7. Conditional   (?:, ??)
//   8. Type Test     (is, is!, as)
//   9. Cascade       (..)
// =============================================================

import 'dart:io';

void main() {
  print('');
  print('        DEMONSTRASI SEMUA OPERATOR DALAM DART         ');
  print('');

  // Ambil input dari pengguna untuk demo interaktif
  print('Masukkan dua bilangan untuk demonstrasi operator:');
  stdout.write('Bilangan pertama (a): ');
  int a = inputInteger();
  stdout.write('Bilangan kedua  (b): ');
  int b = inputInteger();

  demonstrasiAritmatika(a, b);
  demonstrasiRelasional(a, b);
  demonstrasiLogika(a, b);
  demonstrasiAssignment(a, b);
  demonstrasiBitwise(a, b);
  demonstrasiUnary(a);
  demonstrasiConditional(a, b);
  demonstrasiTypeTest();
  demonstrasiCascade();
}


// 1. OPERATOR ARITMATIKA
void demonstrasiAritmatika(int a, int b) {
  print('');
  print('  1. OPERATOR ARITMATIKA');

  print('  a = $a, b = $b');
  print('  a + b  = ${a + b}    (Penjumlahan)');
  print('  a - b  = ${a - b}    (Pengurangan)');
  print('  a * b  = ${a * b}    (Perkalian)');
  print('  a / b  = ${a / b}    (Pembagian - hasil double)');
  print('  a ~/ b = ${a ~/ b}   (Pembagian bulat - integer division)');
  print('  a % b  = ${a % b}    (Modulo - sisa bagi)');
}


// 2. OPERATOR RELASIONAL (PERBANDINGAN)
void demonstrasiRelasional(int a, int b) {
  print('');
  print('  2. OPERATOR RELASIONAL');

  print('  a = $a, b = $b');
  print('  a == b  → ${a == b}   (Sama dengan)');
  print('  a != b  → ${a != b}   (Tidak sama dengan)');
  print('  a >  b  → ${a > b}    (Lebih besar)');
  print('  a <  b  → ${a < b}    (Lebih kecil)');
  print('  a >= b  → ${a >= b}   (Lebih besar atau sama)');
  print('  a <= b  → ${a <= b}   (Lebih kecil atau sama)');
}


// 3. OPERATOR LOGIKA
void demonstrasiLogika(int a, int b) {
  print('');
  print('  3. OPERATOR LOGIKA');

  bool kondisiA = a > 0;   // apakah a positif?
  bool kondisiB = b > 0;   // apakah b positif?

  print('  kondisiA (a > 0) = $kondisiA');
  print('  kondisiB (b > 0) = $kondisiB');
  print('');
  print('  kondisiA && kondisiB → ${kondisiA && kondisiB}   (AND: keduanya harus true)');
  print('  kondisiA || kondisiB → ${kondisiA || kondisiB}   (OR: salah satu cukup true)');
  print('  !kondisiA            → ${!kondisiA}              (NOT: membalik nilai)');
  print('  !kondisiB            → ${!kondisiB}');
}


// 4. OPERATOR ASSIGNMENT (PENUGASAN)
void demonstrasiAssignment(int a, int b) {
  print('');
  print('  4. OPERATOR ASSIGNMENT');

  int x = a;
  print('  x = $a (assignment awal)');

  x += b;
  print('  x += $b  → x = $x   (x = x + b)');

  x -= b;
  print('  x -= $b  → x = $x   (x = x - b, kembali ke semula)');

  x *= 2;
  print('  x *= 2   → x = $x   (x = x * 2)');

  x ~/= 3;
  print('  x ~/= 3  → x = $x   (x = x ~/ 3, integer division)');

  x %= 5;
  print('  x %= 5   → x = $x   (x = x % 5)');

  // Null-aware assignment
  String? nama;
  nama ??= 'Mahasiswa';
  print('  nama ??= "Mahasiswa" → $nama   (assign hanya jika null)');
}


// 5. OPERATOR BITWISE
void demonstrasiBitwise(int a, int b) {
  print('');
  print('  5. OPERATOR BITWISE');

  // Gunakan nilai kecil agar biner mudah dibaca
  int p = a & 0xFF;  // ambil 8 bit bawah saja
  int q = b & 0xFF;

  print('  Menggunakan p = $p (biner: ${p.toRadixString(2).padLeft(8, '0')})');
  print('              q = $q (biner: ${q.toRadixString(2).padLeft(8, '0')})');
  print('');

  int hasil;
  hasil = p & q;
  print('  p & q  = $hasil (biner: ${hasil.toRadixString(2).padLeft(8, '0')})  AND: 1 jika keduanya 1');
  hasil = p | q;
  print('  p | q  = $hasil (biner: ${hasil.toRadixString(2).padLeft(8, '0')})  OR: 1 jika salah satu 1');
  hasil = p ^ q;
  print('  p ^ q  = $hasil (biner: ${hasil.toRadixString(2).padLeft(8, '0')})  XOR: 1 jika berbeda');
  hasil = ~p & 0xFF;
  print('  ~p     = $hasil (biner: ${hasil.toRadixString(2).padLeft(8, '0')})  NOT: membalik semua bit');
  hasil = p << 2;
  print('  p << 2 = $hasil (biner: ${hasil.toRadixString(16)})  Left shift 2 posisi');
  hasil = p >> 2;
  print('  p >> 2 = $hasil (biner: ${hasil.toRadixString(2).padLeft(8, '0')})  Right shift 2 posisi');
}


// 6. OPERATOR UNARY
void demonstrasiUnary(int a) {
  print('');
  print('  6. OPERATOR UNARY');

  int x = a;
  print('  x = $x');

  // Pre-increment / pre-decrement
  print('  ++x → ${++x}   (pre-increment: tambah dulu, baru gunakan)');
  print('  --x → ${--x}   (pre-decrement: kurang dulu, baru gunakan)');

  // Post-increment / post-decrement
  print('  x++ → ${x++}   (post-increment: gunakan dulu, baru tambah)');
  print('  x setelah x++ = $x');
  print('  x-- → ${x--}   (post-decrement: gunakan dulu, baru kurang)');
  print('  x setelah x-- = $x');

  // Negasi
  print('  -x  → ${-x}   (negasi unary)');
}


// 7. OPERATOR CONDITIONAL (TERNARY & NULL-AWARE)
void demonstrasiConditional(int a, int b) {
  print('');
  print('  7. OPERATOR CONDITIONAL');
  print('');

  // Ternary operator: kondisi ? nilaiTrue : nilaiFalse
  String statusA = a >= 0 ? 'non-negatif' : 'negatif';
  print('  a >= 0 ? "non-negatif" : "negatif" → "$statusA"');

  String perbandingan = a > b ? 'a lebih besar' : (a == b ? 'sama besar' : 'b lebih besar');
  print('  Perbandingan a dan b → "$perbandingan"');

  // Null-aware operator (??)
  String? nilaiNull;
  String hasilNull = nilaiNull ?? 'nilai default';
  print('  null ?? "nilai default" → "$hasilNull"   (?? mengembalikan kanan jika kiri null)');

  // Null-aware access (?.)
  String? teks = 'Dart Programming';
  print('  teks?.toUpperCase() → ${teks?.toUpperCase()}');
  teks = null;
  print('  null?.toUpperCase() → ${teks?.toUpperCase()}   (tidak error, mengembalikan null)');
}


// 8. OPERATOR TYPE TEST (is, is!, as)
void demonstrasiTypeTest() {
  print('');
  print('  8. OPERATOR TYPE TEST');
  print('');

  dynamic nilai1 = 42;
  dynamic nilai2 = 'Halo';
  dynamic nilai3 = 3.14;

  print('  nilai1 = $nilai1, nilai2 = "$nilai2", nilai3 = $nilai3');
  print('');
  print('  nilai1 is int    → ${nilai1 is int}    (apakah tipe int?)');
  print('  nilai1 is String → ${nilai1 is String} (apakah tipe String?)');
  print('  nilai2 is String → ${nilai2 is String}');
  print('  nilai2 is! int   → ${nilai2 is! int}   (apakah BUKAN int?)');
  print('  nilai3 is double → ${nilai3 is double}');
  print('  nilai3 is num    → ${nilai3 is num}    (double adalah subtype num)');

  // Operator 'as' untuk type casting
  Object obj = 'Casting Test';
  String str = obj as String;
  print('  obj as String → "$str"   (cast Object ke String)');
}


// 9. CASCADE OPERATOR (..)
void demonstrasiCascade() {
  print('');
  print('  9. CASCADE OPERATOR (..)');
  print('');
  print('  Cascade memungkinkan beberapa operasi pada objek yang sama');
  print('');

  // Contoh dengan StringBuffer menggunakan cascade
  StringBuffer sb = StringBuffer()
    ..write('Nama: Budi ')
    ..write('| NIM: 12345 ')
    ..write('| Kelas: A')
    ..writeln();

  print('  StringBuffer dengan cascade:');
  print('  ${sb.toString()}');

  // Contoh dengan List menggunakan cascade
  List<int> daftarNilai = []
    ..add(85)
    ..add(90)
    ..add(78)
    ..add(92)
    ..add(88);

  print('  List nilai dengan cascade: $daftarNilai');
  double rata = daftarNilai.reduce((a, b) => a + b) / daftarNilai.length;
  print('  Rata-rata nilai: ${rata.toStringAsFixed(2)}');
}


// HELPER: Input integer dengan validasi
int inputInteger() {
  while (true) {
    String? input = stdin.readLineSync();
    if (input != null) {
      int? nilai = int.tryParse(input.trim());
      if (nilai != null) return nilai;
    }
    stdout.write('⚠ Input tidak valid. Masukkan bilangan bulat: ');
  }
}