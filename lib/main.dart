import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme.dart'; // Oluşturduğumuz tema dosyasını import ediyoruz.
import 'screens/auth_wrapper.dart'; // Birazdan oluşturacağımız AuthWrapper'ı import ediyoruz.

// Uygulamanın ana başlangıç noktası.
void main() async {
  // Flutter binding'lerinin başlatıldığından emin oluyoruz.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase servislerini başlatıyoruz.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Uygulamayı çalıştırıyoruz.
  runApp(const VazoKartApp());
}

class VazoKartApp extends StatelessWidget {
  const VazoKartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VazoKart Mobil',
      debugShowCheckedModeBanner: false,
      // Oluşturduğumuz karanlık temayı uyguluyoruz.
      theme: AppTheme.darkTheme,
      // Uygulamanın başlangıç ekranı olarak AuthWrapper'ı belirliyoruz.
      home: const AuthWrapper(),
    );
  }
}
