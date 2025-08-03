import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart'; // Ana ekran
import 'login_screen.dart'; // Giriş ekranı

// Bu widget, Firebase'deki kullanıcı oturum durumunu dinler ve
// duruma göre Ana Ekran veya Giriş Ekranı'nı gösterir.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth'dan kullanıcı durumu değişikliklerini dinleyen bir StreamBuilder.
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Bağlantı bekleniyorsa yükleme göstergesi göster.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Eğer snapshot'ta veri varsa ve kullanıcı null değilse (giriş yapmışsa),
        // HomeScreen'e yönlendir.
        if (snapshot.hasData && snapshot.data != null) {
          return const HomeScreen();
        }

        // Kullanıcı giriş yapmamışsa LoginScreen'e yönlendir.
        return LoginScreen();
      },
    );
  }
}
