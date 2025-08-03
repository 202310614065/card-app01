// lib/screens/card_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardDetailScreen extends StatelessWidget {
  final String cardId;
  const CardDetailScreen({required this.cardId, super.key});
  @override
  Widget build(BuildContext context) {
    final docRef = FirebaseFirestore.instance.collection('cards').doc(cardId);
    return Scaffold(
      appBar: AppBar(title: const Text('Kart Detayı')),
      body: FutureBuilder<DocumentSnapshot>(
        future: docRef.get(),
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final data = snap.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kart No: ${data['number']}'),
                const SizedBox(height: 8),
                Text('Etiket: ${data['label']}'),
                const SizedBox(height: 8),
                Text('Bakiye: ${data['balance']} TL'),
                // vs...
              ],
            ),
          );
        },
      ),
    );
  }
}
