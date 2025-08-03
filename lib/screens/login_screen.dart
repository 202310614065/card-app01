// lib/screens/login_screen.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek giriş işlemi için TextEditingController'lar
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'VazoKart Mobil',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'E-posta',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // TODO: Firebase Auth ile giriş işlemini burada yapın
                  // final email = emailController.text;
                  // final password = passwordController.text;
                  // Örneğin:
                  // try {
                  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
                  //     email: email,
                  //     password: password,
                  //   );
                  //   // Giriş başarılı olursa AuthWrapper zaten yönlendirme yapacaktır.
                  // } on FirebaseAuthException catch (e) {
                  //   // Hata mesajı göster
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Giriş başarısız: ${e.message}')),
                  //   );
                  // }
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Giriş fonksiyonu henüz eklenmedi.')),
                  );
                },
                child: const Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}