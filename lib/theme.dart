import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Uygulamanın genel tema ayarlarını içeren sınıf.
class AppTheme {
  // Ana renk paleti
  static const Color primaryColor = Color(0xFF00BFFF); // Canlı Mavi
  static const Color primaryVariantColor = Color(0xFF009ACD);
  static const Color secondaryColor = Color(0xFF4DD0E1); // Açık Turkuaz
  static const Color backgroundColor = Color(0xFF121212); // Koyu Arka Plan
  static const Color surfaceColor = Color(0xFF1E1E1E); // Kart ve yüzey rengi
  static const Color textColor = Colors.white;
  static const Color textSecondaryColor = Colors.white70;

  // Uygulamanın karanlık temasını oluşturan statik metot.
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      
      // Renk şeması
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        primaryContainer: primaryVariantColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: textColor,
        onBackground: textColor,
        error: Colors.redAccent,
        onError: Colors.white,
      ),

      // AppBar Teması
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent, // Şeffaf AppBar
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: textColor),
      ),

      // Kart Teması
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Buton Temaları
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Giriş Alanı (TextField) Teması
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)), // <-- Fixed here
        prefixIconColor: textSecondaryColor,
      ),

      // İkon Teması
      iconTheme: const IconThemeData(
        color: secondaryColor,
      ),

      // Metin Teması
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(color: textColor, fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.poppins(color: textColor, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.poppins(color: textColor),
        bodyMedium: GoogleFonts.poppins(color: textSecondaryColor),
        labelLarge: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
