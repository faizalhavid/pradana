import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pradana/models/colors.dart';

/// Kelas `ThemeModel` untuk merepresentasikan tema aplikasi.
///
/// Kelas ini memiliki dua properti:
/// - `lightTheme` (ThemeData): Tema terang.
/// - `darkTheme` (ThemeData): Tema gelap.
///
/// Kelas ini juga menyediakan konstruktor dan metode pabrik `defaultTheme`
/// untuk membuat instance `ThemeModel` dengan tema default.
class ThemeModel {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  /// Konstruktor untuk `ThemeModel`.
  ///
  /// Konstruktor ini menerima dua parameter yang diperlukan untuk menginisialisasi
  /// properti kelas.
  ThemeModel({
    required this.lightTheme,
    required this.darkTheme,
  });

  /// Metode pabrik `defaultTheme` untuk membuat instance `ThemeModel` dengan tema default.
  ///
  /// Mengembalikan instance `ThemeModel` dengan tema terang dan gelap yang telah ditentukan.
  factory ThemeModel.defaultTheme() {
    return ThemeModel(
      lightTheme: ThemeData(
        primaryColor: ColorResources.primaryColor,
        primaryColorDark: ColorResources.primaryDarkColor,
        hintColor: ColorResources.secondaryColor,
        scaffoldBackgroundColor: ColorResources.neutral100,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: ColorResources.primaryColor,
          elevation: 0,
          selectedItemColor: ColorResources.primaryColor,
          unselectedItemColor: ColorResources.neutral500,
          selectedLabelStyle: TextStyle(
            fontFamily: 'SFProDisplay',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'SFProDisplay',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorResources.neutral100,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorResources.neutral800),
          titleTextStyle: TextStyle(
            fontFamily: 'SFProDisplay',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorResources.neutral800,
          ),
          surfaceTintColor: ColorResources.neutral0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorResources.neutral0,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: ColorResources.primaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorResources.primaryColor,
            foregroundColor: ColorResources.neutral0,
            disabledBackgroundColor: ColorResources.neutral300,
            disabledForegroundColor: ColorResources.neutral700,
          ),
        ),
        colorScheme: const ColorScheme.light(
          primary: ColorResources.primaryColor,
          secondary: ColorResources.secondaryColor,
          surface: ColorResources.neutral0,
          error: ColorResources.primaryColor,
          onPrimary: ColorResources.neutral0,
          onSecondary: ColorResources.neutral0,
          onSurface: ColorResources.neutral800,
          onError: ColorResources.primaryColor,
          brightness: Brightness.light,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: ColorResources.primaryColor,
          contentTextStyle: TextStyle(
            fontFamily: 'SFProDisplay',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: ColorResources.neutral0,
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.roboto(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: ColorResources.neutral800,
          ),
          headlineMedium: GoogleFonts.roboto(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorResources.neutral800,
          ),
          headlineSmall: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorResources.neutral800,
          ),
          bodyLarge: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: ColorResources.neutral800,
          ),
          bodyMedium: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: ColorResources.neutral800,
          ),
          bodySmall: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: ColorResources.neutral800,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: ColorResources.primaryColor,
        primaryColorDark: ColorResources.primaryDarkColor,
        hintColor: ColorResources.secondaryColor,
        scaffoldBackgroundColor: ColorResources.neutral900,
        appBarTheme: AppBarTheme(
          surfaceTintColor: ColorResources.neutral900,
          backgroundColor: ColorResources.neutral900,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorResources.neutral0),
          titleTextStyle: TextStyle(
            fontFamily: 'SFProDisplay',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorResources.neutral0,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorResources.neutral900,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: ColorResources.primaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorResources.primaryColor,
            foregroundColor: ColorResources.neutral0,
            disabledBackgroundColor: ColorResources.neutral300,
            disabledForegroundColor: ColorResources.neutral700,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: ColorResources.primaryColor,
          secondary: ColorResources.secondaryColor,
          surface: ColorResources.neutral900,
          error: ColorResources.primaryColor,
          onPrimary: ColorResources.neutral0,
          onSecondary: ColorResources.neutral0,
          onSurface: ColorResources.neutral0,
          onError: ColorResources.primaryColor,
          brightness: Brightness.dark,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: ColorResources.secondaryColor,
          contentTextStyle: TextStyle(
            fontFamily: 'SFProDisplay',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: ColorResources.neutral0,
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.roboto(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: ColorResources.neutral0,
          ),
          headlineMedium: GoogleFonts.roboto(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorResources.neutral0,
          ),
          headlineSmall: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorResources.neutral0,
          ),
          bodyLarge: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: ColorResources.neutral0,
          ),
          bodyMedium: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: ColorResources.neutral0,
          ),
          bodySmall: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: ColorResources.neutral0,
          ),
        ),
      ),
    );
  }
}
