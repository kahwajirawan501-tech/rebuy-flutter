import 'package:flutter/material.dart';

/// AppColors: Design System كامل للألوان حسب تصميم Figma
class AppColors {
  AppColors._(); // private constructor

  // === Primary Colors ===
  static const Color primary = Color(0xFFC1839F);
  static const Color primaryLight = Color(0xFFF5F5F5);
  static const Color primaryDark = Color(0xFFFF5A5F);

  // === Primary MaterialColor for ThemeData ===
  static const MaterialColor primarySwatch = MaterialColor(
    0xFFC1839F, // اللون الرئيسي
    <int, Color>{
      50: Color(0xFFFFF1F4),
      100: Color(0xFFFFD9E0),
      200: Color(0xFFFFB3C7),
      300: Color(0xFFFF8BAE),
      400: Color(0xFFFF6599),
      500: Color(0xFFC1839F),
      600: Color(0xFFB26E89),
      700: Color(0xFF995C74),
      800: Color(0xFF7F4A60),
      900: Color(0xFF64384C),
    },
  );
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFFF5A5F),
      Color(0xFFC1839F),
    ],
  );
  // === Secondary Colors / Accent ===
  static const Color secondary = Color(0xFF087E8B);
  static const Color secondaryLight = Color(0xFFD4E4E6);
  static const Color secondaryDark = Color(0xFF065F63);

  // === Text Colors ===
  static const Color textPrimaryDark = Color(0xFF3C3C3C);
  static const Color textPrimaryLight = Color(0xFF8D8D8D);
  static const Color textPrimary = Color(0xFF6F6F6F);
  static const Color text = Color(0xFF747474);


  static const Color textSecondary = Color(0xFFFF5A5F);

  static const Color textType = Color(0xFFE2E2E2);

  // === Backgrounds ===
  static const Color background = Color(0xFFF5F5F5); // خلفية عامة
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundSearchBox = Color(0xFFDEDEDE);

  // === Icons ===
  static const Color icon = Color(0xFF5F5F5F);
  static const Color iconLight = Color(0xFFD9D9D9);



  // === Lines / Borders ===
  static const Color line = Color(0xFF6F6F6F);
  static const Color lineDark = Color(0xFF3C3C3C);
  static const Color divider = Color(0xFF828282);

// === Status Colors  ===
  static const Color success = Color(0xFFDEDEDE);
  static const Color error   = Color(0xFFFF5A5F);
  static const Color warning = Color(0xFFFFA726);
  static const Color info    = Color(0xFF087E8B);
}