// lib/theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueGrey,
        colorScheme: ColorScheme.dark(
          primary: Colors.blueGrey,
          secondary: Colors.tealAccent,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          elevation: 0,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        cardTheme: CardThemeData(
          color: Colors.grey[850],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        iconTheme: const IconThemeData(color: Colors.tealAccent),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900],
          selectedItemColor: Colors.tealAccent,
          unselectedItemColor: Colors.white54,
          showUnselectedLabels: true,
        ),
      );
}
