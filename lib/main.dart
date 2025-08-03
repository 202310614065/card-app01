import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme.dart';
import 'screens/auth_wrapper.dart';

void main() async {
  // Flutter binding'lerinin ve Firebase'in başlatılmasını garantiler.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const VazoKartApp());
}

class VazoKartApp extends StatelessWidget {
  const VazoKartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VazoKart Mobil',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AuthWrapper(),
    );
  }
}
