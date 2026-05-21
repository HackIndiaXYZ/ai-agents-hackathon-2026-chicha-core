import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundVoid,
      primaryColor: AppColors.indigoPrimary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.violetAccent,
        secondary: AppColors.amberHighlight,
        tertiary: AppColors.tealAccent,
        surface: AppColors.greyCard,
        error: Colors.redAccent,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.sora(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.warmWhite,
          letterSpacing: -0.04 * 32,
        ),
        displayMedium: GoogleFonts.sora(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.warmWhite,
          letterSpacing: -0.04 * 24,
        ),
        displaySmall: GoogleFonts.sora(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.warmWhite,
        ),
        headlineMedium: GoogleFonts.sora(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.warmWhite,
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'Georgia',
          fontSize: 16,
          height: 1.75,
          color: AppColors.warmWhite,
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'Georgia',
          fontSize: 14,
          height: 1.75,
          color: AppColors.greyText,
        ),
        labelLarge: GoogleFonts.sora(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.warmWhite,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.warmWhite),
      ),
      cardTheme: CardThemeData(
        color: AppColors.greyCard,
        elevation: 8,
        shadowColor: AppColors.glowViolet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppColors.indigoPrimary, width: 1),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundVoid,
        selectedItemColor: AppColors.violetAccent,
        unselectedItemColor: AppColors.greyText,
        elevation: 10,
      ),
    );
  }
}
