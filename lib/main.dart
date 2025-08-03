// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme.dart';
import 'screens/root_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const VazoKartApp());
}

class VazoKartApp extends StatelessWidget {
  const VazoKartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VazoKart Mobil',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const RootPage(),
    );
  }
}