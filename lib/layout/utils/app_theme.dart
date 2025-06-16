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
      primary: Color.fromARGB(255, 0, 110, 221),
      secondary: Color.fromARGB(255, 111, 186, 113),
      tertiary: const Color.fromARGB(255, 255, 0, 238),
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: const Color.fromARGB(255, 32, 32, 32),
      surfaceBright: Colors.black,
      outline: Colors.blueGrey.withAlpha(60),
    );

    return ThemeData.light().copyWith(
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(colorScheme),
    );
  }

  static ThemeData darkTheme() {
    final colorScheme = ColorScheme.dark(
      primary: Colors.pink.shade400,
      secondary: Colors.purple.shade400,
      tertiary: const Color.fromARGB(255, 0, 16, 163),
      onPrimary: Colors.white,
      surface: Colors.black,
      onSurface: const Color.fromARGB(255, 226, 226, 226),
      surfaceBright: Color.fromARGB(255, 255, 218, 108),
      outline: const Color.fromARGB(255, 141, 198, 226).withAlpha(70),
    );

    return ThemeData.dark().copyWith(
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(colorScheme),
    );
  }
}
