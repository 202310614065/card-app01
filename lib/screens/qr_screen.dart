// lib/screens/qr_screen.dart
import 'package:flutter/material.dart';
class QrScreen extends StatelessWidget {
  const QrScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR ile Öde'), centerTitle: true),
      body: const Center(child: Icon(Icons.qr_code, size: 120)),
    );
  }
}
