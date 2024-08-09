import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/providers/controllers/theme.dart';
import 'package:pradana/models/theme.dart';

/// Provider `themeModelProvider` untuk menyediakan instance `ThemeModel`.
///
/// Provider ini menggunakan `Provider` dari Riverpod untuk mengembalikan
/// instance `ThemeModel` dengan tema default.
final themeModelProvider = Provider<ThemeModel>((ref) {
  return ThemeModel.defaultTheme();
});

/// Provider `themeControllerProvider` untuk menyediakan instance `ThemeController`
/// dan state `ThemeData`.
///
/// Provider ini menggunakan `StateNotifierProvider` dari Riverpod untuk mengelola
/// state berupa `ThemeData`. Provider ini bergantung pada `themeModelProvider`
/// untuk mendapatkan instance `ThemeModel` yang digunakan oleh `ThemeController`.
final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeData>((ref) {
  final themeModel = ref.watch(themeModelProvider);
  final brightness = WidgetsBinding.instance.window.platformBrightness;
  return ThemeController(themeModel, brightness);
});
