// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_error != null) ...[
                Text(_error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
              ],
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'E-posta',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v != null && v.contains('@') ? null : 'Geçerli bir e-posta girin',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pwdCtrl,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) => v != null && v.length >= 6 ? null : 'En az 6 karakter',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loading ? null : _doLogin,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Giriş Yap'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text('Hesap oluştur'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _doLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _pwdCtrl.text.trim(),
      );
      if (mounted) Navigator.pop(context, true);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message;
      });
    } finally {
      if (mounted) setState(() {
        _loading = false;
      });
    }
  }
}
