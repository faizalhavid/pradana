import 'package:flutter/material.dart';

/// Kelas `ColorResources` untuk menyimpan konstanta warna yang digunakan dalam aplikasi.
///
/// Kelas ini memiliki beberapa kategori warna:
///
/// - Warna Utama (Primary Colors):
///   - `primaryColor`: Warna utama dengan kode warna `0xFFC70C3C`.
///   - `primaryDarkColor`: Warna utama gelap dengan kode warna `0xFFB71C1C`.
///
/// - Warna Sekunder (Secondary Colors):
///   - `secondaryColor`: Warna sekunder dengan kode warna `0xFF3544C4`.
///
/// - Warna Netral (Neutral Colors):
///   - `gray`: Warna abu-abu dengan kode warna `0xFFCECFCF`.
///   - `grayLight`: Warna abu-abu terang dengan kode warna `0xFFE0E0E0`.
///   - `neutral0`: Warna netral dengan kode warna `ARGB(255, 255, 255, 255)`.
///   - `neutral50`: Warna netral dengan kode warna `0xFFE0E0E0`.
///   - `neutral100`: Warna netral dengan kode warna `0xFFF5F6F7`.
///   - `neutral200`: Warna netral dengan kode warna `0xFFE0E0E0`.
///   - `neutral300`: Warna netral dengan kode warna `0xFFBDBDBD`.
///   - `neutral400`: Warna netral dengan kode warna `0xFF9E9E9E`.
///   - `neutral500`: Warna netral dengan kode warna `0xFF757575`.
///   - `neutral600`: Warna netral dengan kode warna `0xFF616161`.
///   - `neutral700`: Warna netral dengan kode warna `0xFF424242`.
///   - `neutral800`: Warna netral dengan kode warna `0xFF212121`.
///   - `neutral900`: Warna netral dengan kode warna `0xFF121212`.
class ColorResources {
  // Warna Utama
  static const Color primaryColor = Color(0xFFC70C3C);
  static const Color primaryDarkColor = Color(0xFFB71C1C);

  // Warna Sekunder
  static const Color secondaryColor = Color(0xFF3544C4);

  // Warna Netral
  static const Color gray = Color(0xFFCECFCF);
  static const Color grayLight = Color(0xFFE0E0E0);
  static const Color neutral0 = Color.fromARGB(255, 255, 255, 255);
  static const Color neutral50 = Color(0xFFE0E0E0);
  static const Color neutral100 = Color(0xFFF5F6F7);
  static const Color neutral200 = Color(0xFFE0E0E0);
  static const Color neutral300 = Color(0xFFBDBDBD);
  static const Color neutral400 = Color(0xFF9E9E9E);
  static const Color neutral500 = Color(0xFF757575);
  static const Color neutral600 = Color(0xFF616161);
  static const Color neutral700 = Color(0xFF424242);
  static const Color neutral800 = Color(0xFF212121);
  static const Color neutral900 = Color(0xFF121212);
}
