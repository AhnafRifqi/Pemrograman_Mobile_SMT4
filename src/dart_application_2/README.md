# Laporan Praktikum Dart

## Tugas yang Dikerjakan

1. BMI Calculator — menghitung BMI dari input berat dan tinggi, menampilkan kategori dan saran kesehatan.
2. Konversi Mata Uang — mengkonversi antara 6 mata uang (IDR, USD, EUR, GBP, JPY, SGD) menggunakan Map kurs.
3. Demonstrasi Operator — menampilkan semua jenis operator Dart secara interaktif (aritmatika, logika, bitwise, cascade, dll).
4. Unit Converter (tantangan) — konversi panjang, massa, volume, dan suhu dengan validasi input negatif.


## Kendala & Solusi

- Suhu tidak bisa dikonversi dengan faktor perkalian biasa → diselesaikan dengan konversi dua langkah melalui Celsius.
- Input tidak valid menyebabkan crash → diselesaikan dengan `double.tryParse()` dan loop validasi.
- Hasil angka terlalu kecil/besar → diselesaikan dengan fungsi format otomatis yang memilih antara desimal dan notasi saintifik.