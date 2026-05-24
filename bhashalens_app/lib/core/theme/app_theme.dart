import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bhashalens_app/core/theme/app_colors.dart';

class AppTheme {
  /// Light theme configuration using SamvadAI brand identity
  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.loraTextTheme().copyWith(
      displayLarge: GoogleFonts.sora(
        fontWeight: FontWeight.bold,
        color: AppColors.indigoPrimary,
        letterSpacing: -0.04 * 57,
      ),
      displayMedium: GoogleFonts.sora(
        fontWeight: FontWeight.bold,
        color: AppColors.indigoPrimary,
        letterSpacing: -0.04 * 45,
      ),
      displaySmall: GoogleFonts.sora(
        fontWeight: FontWeight.bold,
        color: AppColors.indigoPrimary,
        letterSpacing: -0.04 * 36,
      ),
      headlineLarge: GoogleFonts.sora(
        fontWeight: FontWeight.w600,
        color: AppColors.indigoPrimary,
        letterSpacing: -0.04 * 32,
      ),
      headlineMedium: GoogleFonts.sora(
        fontWeight: FontWeight.w600,
        color: AppColors.indigoPrimary,
        letterSpacing: -0.04 * 28,
      ),
      headlineSmall: GoogleFonts.sora(
        fontWeight: FontWeight.w600,
        color: AppColors.indigoPrimary,
        letterSpacing: -0.04 * 24,
      ),
      titleLarge: GoogleFonts.sora(
        fontWeight: FontWeight.w600,
        color: AppColors.indigoPrimary,
      ),
      titleMedium: GoogleFonts.sora(
        fontWeight: FontWeight.w500,
        color: AppColors.indigoPrimary,
      ),
      titleSmall: GoogleFonts.sora(
        fontWeight: FontWeight.w500,
        color: AppColors.indigoPrimary,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: textTheme,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.indigoPrimary,
        onPrimary: Colors.white,
        primaryContainer: Color(0xFFE2E0FF), 
        onPrimaryContainer: AppColors.indigoPrimary,
        secondary: AppColors.violetAccent,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFF1F0FF),
        onSecondaryContainer: AppColors.indigoPrimary,
        surface: Colors.white,
        onSurface: AppColors.indigoPrimary,
        surfaceContainerHighest: AppColors.warmWhiteBg,
        onSurfaceVariant: AppColors.slate600,
        error: AppColors.error,
        onError: Colors.white,
        outline: AppColors.border,
        outlineVariant: AppColors.slate200,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.warmWhiteBg,
        foregroundColor: AppColors.indigoPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.sora(
          color: AppColors.indigoPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.indigoPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.slate50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.indigoPrimary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  /// Dark theme configuration using SamvadAI brand identity
  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.loraTextTheme()
        .apply(
          bodyColor: AppColors.textDark,
          displayColor: AppColors.textDark,
        )
        .copyWith(
          displayLarge: GoogleFonts.sora(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            letterSpacing: -0.04 * 57,
          ),
          displayMedium: GoogleFonts.sora(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            letterSpacing: -0.04 * 45,
          ),
          displaySmall: GoogleFonts.sora(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            letterSpacing: -0.04 * 36,
          ),
          headlineLarge: GoogleFonts.sora(
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
            letterSpacing: -0.04 * 32,
          ),
          headlineMedium: GoogleFonts.sora(
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
            letterSpacing: -0.04 * 28,
          ),
          headlineSmall: GoogleFonts.sora(
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
            letterSpacing: -0.04 * 24,
          ),
          titleLarge: GoogleFonts.sora(
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          titleMedium: GoogleFonts.sora(
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
          titleSmall: GoogleFonts.sora(
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: textTheme,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.violetAccent,
        onPrimary: AppColors.voidBg,
        primaryContainer: AppColors.indigoPrimary,
        onPrimaryContainer: Colors.white,
        secondary: AppColors.tealAccent,
        onSecondary: AppColors.voidBg,
        secondaryContainer: AppColors.surfaceDark,
        onSecondaryContainer: Colors.white,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textDark,
        surfaceContainerHighest: AppColors.voidBg,
        onSurfaceVariant: AppColors.slate400,
        error: AppColors.error,
        onError: Colors.white,
        outline: AppColors.borderDark,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.voidBg,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.sora(
          color: AppColors.textDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.violetAccent,
          foregroundColor: AppColors.voidBg,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF141432),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.violetAccent, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.success,
    required this.warning,
    required this.info,
  });

  final Color success;
  final Color warning;
  final Color info;

  @override
  CustomColors copyWith({Color? success, Color? warning, Color? info}) {
    return CustomColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }

  static CustomColors of(BuildContext context) =>
      Theme.of(context).extension<CustomColors>()!;
}
