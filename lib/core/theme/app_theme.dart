import 'package:flutter/material.dart';

class AppTheme {
  // 🌿 Brand colors
  static const primaryColor = Color(0xFF22C55E); // fresh green
  static const secondaryColor = Color(0xFF3B82F6); // blue
  static const accentColor = Color(0xFFF59E0B); // amber

  // 🎨 Backgrounds
  static const creamBackground = Color.fromARGB(255, 252, 249, 246); // cream
  static const darkBackground = Color(0xFF121212);

  // 🧱 Surfaces
  static const cardColor = Colors.white;

  // ✍️ Text
  static const textColor = Color(0xFF1F2937);
  static const textLightColor = Color(0xFF6B7280);

  // 🌞 LIGHT THEME
  static final lightTheme = ThemeData(
    useMaterial3: true,

    // IMPORTANT 🔥
    scaffoldBackgroundColor: creamBackground,

    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: creamBackground,
      surface: cardColor,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: creamBackground,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: textColor),
    ),

    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );

  // 🌙 DARK THEME
  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      background: darkBackground,
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
