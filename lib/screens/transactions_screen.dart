// lib/screens/transactions_screen.dart
import 'package:flutter/material.dart';
class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('İşlemler'), centerTitle: true),
      body: const Center(child: Text('İşlem geçmişi buraya gelecek')),
    );
  }
}
