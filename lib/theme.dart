import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Core palette — purple light theme
  static const Color bgLight      = Color(0xFFF7F9FC);
  static const Color bgCard       = Color(0xFFFFFFFF);
  static const Color bgSurface    = Color(0xFFF3E5F5); // Lighter purple hint for surfaces
  static const Color purple       = Color(0xFFAB47BC); // Lighter primary purple
  static const Color purpleDark   = Color(0xFF8E24AA);
  static const Color purpleGlow   = Color(0x33AB47BC);
  static const Color amber        = Color(0xFFFF9800);
  static const Color white        = Color(0xFFFFFFFF);
  static const Color textPrimary  = Color(0xFF1E1B4B); // Deep purple/navy
  static const Color textSecondary= Color(0xFF64748B);
  static const Color textHint     = Color(0xFF94A3B8);
  static const Color borderDim    = Color(0xFFE2E8F0);
  static const Color borderFocus  = Color(0xFF7C3AED);
  static const Color success      = Color(0xFF10B981);
  static const Color danger       = Color(0xFFEF4444);
  static const Color warning      = Color(0xFFF59E0B);

  // Home screen accent colors per role
  static const List<Color> roleColors = [
    Color(0xFF7C3AED),
    Color(0xFF3B82F6),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
    Color(0xFF06B6D4),
    Color(0xFFF59E0B),
  ];

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: bgLight,
    colorScheme: const ColorScheme.light(
      primary: purple,
      secondary: amber,
      surface: bgCard,
      error: danger,
    ),
    textTheme: GoogleFonts.dmSansTextTheme(ThemeData.light().textTheme),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: purple,
        foregroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 16),
        elevation: 0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: bgSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderDim),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderDim),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderFocus, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: danger),
      ),
      labelStyle: GoogleFonts.dmSans(color: textSecondary, fontSize: 14),
      hintStyle: GoogleFonts.dmSans(color: textHint, fontSize: 14),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((s) =>
          s.contains(WidgetState.selected) ? purple : Colors.transparent),
      checkColor: WidgetStateProperty.all(white),
      side: const BorderSide(color: borderDim, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  );
}
