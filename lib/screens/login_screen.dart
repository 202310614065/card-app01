// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Basit anonim sign-in örneği
    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Anonim Giriş Yap'),
          onPressed: () async {
            await FirebaseAuth.instance.signInAnonymously();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
