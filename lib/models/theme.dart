import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pradana/models/colors.dart';

class ThemeModel {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  ThemeModel({
    required this.lightTheme,
    required this.darkTheme,
  });

  factory ThemeModel.defaultTheme() {
    return ThemeModel(
        lightTheme: ThemeData(
          primaryColor: ColorResources.primaryColor,
          primaryColorDark: ColorResources.primaryDarkColor,
          hintColor: ColorResources.secondaryColor,
          scaffoldBackgroundColor: ColorResources.neutral0,
          appBarTheme: AppBarTheme(
            backgroundColor: ColorResources.neutral0,
            elevation: 0,
            iconTheme: IconThemeData(color: ColorResources.neutral800),
            titleTextStyle: TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorResources.neutral800,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorResources.neutral0,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          buttonBarTheme: ButtonBarThemeData(
            alignment: MainAxisAlignment.center,
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
          buttonBarTheme: ButtonBarThemeData(
            alignment: MainAxisAlignment.center,
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
        ));
  }
}
