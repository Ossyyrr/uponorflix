import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return GoogleFonts.loraTextTheme().apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );
  }

  static ThemeData lightTheme() {
    final colorScheme = ColorScheme.light(
      primary: Color(0xFF006199), // Uponor blue
      secondary: Color(0xFF00796B),
      tertiary: Color(0xFFB39DDB),
      onPrimary: Colors.white,
      surface: Color(0xFFF5F5F5),
      onSurface: Color(0xFF212121),
      surfaceBright: Color(0xFFE3F2FD),
      outline: Color(0xFF90A4AE),
    );

    return ThemeData.light().copyWith(
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(colorScheme),
    );
  }

  static ThemeData darkTheme() {
    final colorScheme = ColorScheme.dark(
      primary: Colors.pink.shade400,
      secondary: Color(0xFF80CBC4),
      tertiary: Color(0xFF9575CD),
      onPrimary: Colors.black,
      surface: Color(0xFF121212),
      onSurface: Color(0xFFF5F5F5),
      surfaceBright: Color(0xFF263238),
      outline: Color(0xFFB0BEC5),
    );

    return ThemeData.dark().copyWith(
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(colorScheme),
    );
  }
}
