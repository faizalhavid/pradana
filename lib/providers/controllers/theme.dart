import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/theme.dart';

/// Kelas `ThemeController` untuk mengelola tema aplikasi.
///
/// Kelas ini menggunakan `StateNotifier` untuk mengelola state berupa `ThemeData`.
/// `ThemeController` menyediakan metode untuk mengganti tema antara tema terang
/// dan tema gelap.
class ThemeController extends StateNotifier<ThemeData> {
  /// Model tema yang berisi tema terang dan tema gelap.
  final ThemeModel _themes;

  /// Konstruktor untuk `ThemeController`.
  ///
  /// Menginisialisasi state dengan tema berdasarkan brightness dari `_themes`.
  ThemeController(this._themes, Brightness initialBrightness)
      : super(initialBrightness == Brightness.light
            ? _themes.lightTheme
            : _themes.darkTheme);

  /// Mengganti tema aplikasi.
  ///
  /// Jika tema saat ini adalah tema terang, maka akan diganti menjadi tema gelap.
  /// Sebaliknya, jika tema saat ini adalah tema gelap, maka akan diganti menjadi tema terang.
  void toggleTheme() {
    state = state.brightness == Brightness.light
        ? _themes.darkTheme
        : _themes.lightTheme;
  }
}
