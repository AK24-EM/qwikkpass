import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette - Nightlife inspired
  static const Color primaryYellow = Color.fromARGB(255, 21, 119, 1);
  static const Color backgroundDark = Color(0xFF0A0C10);
  static const Color surfaceDark = Color(0xFF12151C);
  static const Color cardDark = Color(0xFF1A1E27);
  static const Color borderGray = Color(0xFF2A2F3A);
  static const Color textPrimary = Color(0xFFE8E9EB);
  static const Color textSecondary = Color(0xFF9BA1A6);
  static const Color textTertiary = Color(0xFF6B7280);
  static const Color accentBlue = Color(0xFF4F46E5);
  static const Color accentPurple = Color(0xFF7C3AED);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentRed = Color.fromARGB(255, 76, 170, 3);
  static const Color perforationBg = Color(0xFF0D0F14);

  // Semantic color
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,

      colorScheme: const ColorScheme.dark(
        primary: primaryYellow,
        secondary: accentPurple,
        surface: surfaceDark,
        background: backgroundDark,
        error: error,
        onPrimary: backgroundDark,
        onSecondary: textPrimary,
        onSurface: textPrimary,
        onBackground: textPrimary,
        onError: textPrimary,
      ),

      // Typography
      textTheme: TextTheme(
        // Display - Bold condensed
        displayLarge: GoogleFonts.bebasNeue(
          fontSize: 56,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          height: 1.0,
          letterSpacing: 0.5,
        ),
        displayMedium: GoogleFonts.bebasNeue(
          fontSize: 44,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          height: 1.1,
          letterSpacing: 0.5,
        ),
        displaySmall: GoogleFonts.bebasNeue(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          height: 1.1,
          letterSpacing: 0.5,
        ),

        // Headline - Bold condensed
        headlineLarge: GoogleFonts.bebasNeue(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          height: 1.2,
          letterSpacing: 0.5,
        ),
        headlineMedium: GoogleFonts.bebasNeue(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          height: 1.2,
          letterSpacing: 0.5,
        ),
        headlineSmall: GoogleFonts.bebasNeue(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          height: 1.2,
          letterSpacing: 0.5,
        ),

        // Title - Clean sans
        titleLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          height: 1.3,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          height: 1.3,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          height: 1.3,
        ),

        // Body - Clean sans
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimary,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textPrimary,
          height: 1.5,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.5,
        ),

        // Label - Clean sans
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          height: 1.3,
          letterSpacing: 0.1,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          height: 1.3,
          letterSpacing: 0.1,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          height: 1.3,
          letterSpacing: 0.1,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: borderGray, width: 1),
        ),
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceDark,
        selectedItemColor: primaryYellow,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryYellow, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: GoogleFonts.inter(color: textTertiary, fontSize: 14),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryYellow,
          foregroundColor: backgroundDark,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryYellow,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: cardDark,
        selectedColor: primaryYellow.withOpacity(0.2),
        disabledColor: cardDark.withOpacity(0.5),
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        secondaryLabelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: backgroundDark,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        side: BorderSide(color: borderGray),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: borderGray,
        thickness: 1,
        space: 1,
      ),
    );
  }

  // Monospace text style for data fields
  static TextStyle monospaceLarge(BuildContext context) {
    return GoogleFonts.robotoMono(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: textPrimary,
      letterSpacing: 0.5,
    );
  }

  static TextStyle monospaceMedium(BuildContext context) {
    return GoogleFonts.robotoMono(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: textPrimary,
      letterSpacing: 0.5,
    );
  }

  static TextStyle monospaceSmall(BuildContext context) {
    return GoogleFonts.robotoMono(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: textSecondary,
      letterSpacing: 0.5,
    );
  }

  static TextStyle monospaceXSmall(BuildContext context) {
    return GoogleFonts.robotoMono(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: textTertiary,
      letterSpacing: 0.3,
    );
  }

  // Monospace for large counters (queue screen)
  static TextStyle monospaceDisplay(BuildContext context) {
    return GoogleFonts.robotoMono(
      fontSize: 64,
      fontWeight: FontWeight.w700,
      color: textPrimary,
      letterSpacing: 2,
      height: 1.0,
    );
  }
}
