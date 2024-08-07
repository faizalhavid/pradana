import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/providers/controllers/theme.dart';
import 'package:pradana/models/theme.dart';

final themeModelProvider = Provider<ThemeModel>((ref) {
  return ThemeModel.defaultTheme();
});

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeData>((ref) {
  final themeModel = ref.watch(themeModelProvider);
  return ThemeController(themeModel);
});
