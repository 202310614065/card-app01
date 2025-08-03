import 'package:flutter/material.dart';
// EKLENDİ: LoginScreen'in bulunduğu dosyayı import ediyoruz.
import 'package:card_app/screens/login_screen.dart'; 

void main() {
  runApp(const VazoKartApp());
}

class VazoKartApp extends StatelessWidget {
  // EKLENDİ: İyi pratikler için constructor'a key ekliyoruz.
  const VazoKartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VazoKart Mobil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        primaryColor: const Color(0xFF00BFFF),
        fontFamily: 'Poppins',
      ),
      // Artık LoginScreen tanınıyor.
      home: LoginScreen(), 
    );
  }
}