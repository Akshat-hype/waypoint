import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor:
        const Color(0xFF0F172A),

    primaryColor:
        const Color(0xFF8B5CF6),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF8B5CF6),
      secondary: Color(0xFF06B6D4),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),

    inputDecorationTheme:
        InputDecorationTheme(
      filled: true,

      fillColor:
          const Color(0xFF1E293B),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide: BorderSide.none,
      ),
    ),
  );
}