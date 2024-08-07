import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/theme.dart';

class ThemeController extends StateNotifier<ThemeData> {
  final ThemeModel _themes;

  ThemeController(this._themes) : super(_themes.lightTheme);

  void toggleTheme() {
    state = state.brightness == Brightness.light
        ? _themes.darkTheme
        : _themes.lightTheme;
  }
}
