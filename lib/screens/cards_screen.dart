// lib/screens/cards_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
import 'card_detail_screen.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kartlarım'), centerTitle: true),
        body: Center(
          child: ElevatedButton(
            child: const Text('Giriş Yap'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            ),
          ),
        ),
      );
    }

    final cardsRef = FirebaseFirestore.instance
        .collection('cards')
        .where('ownerId', isEqualTo: user.uid);

    return Scaffold(
      appBar: AppBar(title: const Text('Kartlarım'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: cardsRef.snapshots(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          final docs = snap.data!.docs;
          if (docs.isEmpty) {
            return Center(child: Text('Henüz kart eklenmemiş.'));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final data = docs[i].data() as Map<String, dynamic>;
              return ListTile(
                leading: const Icon(Icons.credit_card),
                title: Text(data['number'] ?? '–––'),
                subtitle: Text(data['label'] ?? ''),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CardDetailScreen(cardId: docs[i].id)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // TODO: Kart ekleme akışı
        },
      ),
    );
  }
}
