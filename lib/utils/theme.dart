import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      primaryColor: const Color(0xFF4CAF50),
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF4CAF50),
        secondary: const Color(0xFF81C784),
        error: const Color(0xFFD32F2F),
        surface: Colors.white,
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.poppins(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        headlineMedium: GoogleFonts.poppins(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
        bodyLarge: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87),
        bodyMedium: GoogleFonts.poppins(
            fontSize: 14, color: Colors.black87),
        labelLarge: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF4CAF50)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF4CAF50),
        titleTextStyle: GoogleFonts.poppins(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF4CAF50),
      ),
    );
  }
}
