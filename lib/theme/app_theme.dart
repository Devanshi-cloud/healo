import 'package:flutter/material.dart';

class AppTheme {
  // Calming Color Palette
  static const Color primaryTeal = Color(0xFF26A69A);
  static const Color primaryTealDark = Color(0xFF00897B);
  static const Color primaryTealLight = Color(0xFF80CBC4);
  static const Color accentGreen = Color(0xFF66BB6A);
  static const Color backgroundLight = Color(0xFFF5F9F8);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color softGrey = Color(0xFFF0F4F3);
  static const Color textDark = Color(0xFF1C3A36);
  static const Color textMuted = Color(0xFF5A7A74);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryTeal,
        brightness: Brightness.light,
        primary: primaryTeal,
        onPrimary: Colors.white,
        primaryContainer: primaryTealLight.withOpacity(0.3),
        onPrimaryContainer: primaryTealDark,
        secondary: accentGreen,
        onSecondary: Colors.white,
        surface: surfaceWhite,
        onSurface: textDark,
        surfaceContainerHighest: softGrey,
        error: const Color(0xFFE57373),
      ),
      scaffoldBackgroundColor: backgroundLight,
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: softGrey,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryTeal, width: 2),
        ),
        hintStyle: TextStyle(
          color: textMuted.withOpacity(0.6),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryTeal,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryTeal,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceWhite,
        selectedItemColor: primaryTeal,
        unselectedItemColor: textMuted.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textDark,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textDark,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: textDark,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: textDark,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: textDark,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: textDark,
        ),
        bodyMedium: TextStyle(
          color: textDark,
        ),
        bodySmall: TextStyle(
          color: textMuted,
        ),
        labelLarge: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: textMuted,
        ),
        labelSmall: TextStyle(
          color: textMuted,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return softGrey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryTeal;
          }
          return textMuted.withOpacity(0.3);
        }),
      ),
    );
  }
}

