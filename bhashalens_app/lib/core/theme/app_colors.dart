import 'package:flutter/material.dart';

/// App color palette based on SamvadAI brand design system
class AppColors {
  // --- CORE BRAND COLORS ---
  static const Color voidBg = Color(0xFF0A0915);        // Dark mode main background
  static const Color indigoPrimary = Color(0xFF191554); // Primary theme color
  static const Color violetAccent = Color(0xFF858CF6);  // Accent A
  static const Color amberAccent = Color(0xFFF59E0B);   // Accent B
  static const Color tealAccent = Color(0xFF0D9488);    // Accent C
  static const Color warmWhiteBg = Color(0xFFFAFAF9);   // Light mode main background

  // --- GRAYSCALE SLATE PALETTE ---
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate950 = Color(0xFF020617);

  // --- BRAND SCHEME MAPS ---
  static const Color primary = indigoPrimary;
  static const Color primaryLight = violetAccent;
  static const Color primaryDark = voidBg;

  static const Color secondary = violetAccent;
  static const Color secondaryLight = violetAccent;
  static const Color secondaryDark = indigoPrimary;

  static const Color background = warmWhiteBg;
  static const Color backgroundDark = voidBg;
  static const Color surface = Colors.white;
  static const Color surfaceDark = Color(0xFF13103B); // Sleek Indigo-void container for cards
  
  static const Color text = Color(0xFF0F172A);
  static const Color textLight = slate500;
  static const Color textMuted = slate500;
  static const Color textOnPrimary = Colors.white;
  static const Color textOnSecondary = Colors.white;
  static const Color textDark = Colors.white;

  static const Color border = slate200;
  static const Color borderDark = Color(0xFF231F6D);
  static const Color divider = slate200;
  static const Color dividerDark = Color(0xFF231F6D);

  // States
  static const Color success = tealAccent;
  static const Color error = Color(0xFFEF4444);
  static const Color warning = amberAccent;
  static const Color info = violetAccent;

  static const Color sosRed = Color(0xFFEF4444);

  // Layout Helpers
  static const Color shadow = Color(0x1A000000); 
  static const Color overlay = Color(0x80000000); 

  // --- LEGACY BACKWARD LINKAGE FOR COMPATIBILITY ---
  static const Color blue50 = Color(0xFFF1F0FF);        // Mapped to soft Violet bg
  static const Color blue100 = Color(0xFFE2E0FF);       // Mapped to soft Violet container
  static const Color blue500 = violetAccent;            // Mapped to Violet Accent
  static const Color blue600 = indigoPrimary;           // Mapped to Indigo Primary
  static const Color blue700 = voidBg;                  // Mapped to Void Dark

  // Gradients for glassmorphism and accents
  static const List<Color> blueGradient = [indigoPrimary, violetAccent];
  static const List<Color> darkGradient = [voidBg, Color(0xFF13103B)];
}
