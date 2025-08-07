import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color lightGreen = Color(0xFF8BC34A);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color accentGreen = Color(0xFFAED581);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;
  static const Color textDark = Color(0xFF263238);
  static const Color textLight = Color(0xFF78909C);
  static const Color errorColor = Color(0xFFE57373);

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: primaryGreen,
      secondary: accentGreen,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: textDark,
      onSurface: textDark,
      onBackground: textDark,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      displayMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      displaySmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      titleLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: textDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: textDark,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceColor,
      foregroundColor: textDark,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        side: const BorderSide(color: primaryGreen, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryGreen,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryGreen, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 1),
      ),
      hintStyle: const TextStyle(color: textLight, fontSize: 14),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.black12,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryGreen,
      unselectedItemColor: textLight,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    scaffoldBackgroundColor: backgroundColor,
    dividerTheme: const DividerThemeData(
      color: Color(0xFFEEEEEE),
      thickness: 1,
      space: 1,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Poppins',
  );
} 