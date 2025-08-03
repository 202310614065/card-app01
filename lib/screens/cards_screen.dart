import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';
import '../models/card_model.dart';
import 'login_screen.dart';
import 'add_card_screen.dart';
import 'card_detail_screen.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, authSnap) {
        if (authSnap.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final user = authSnap.data;
        if (user == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Kartlarım'), centerTitle: true),
            body: Center(
              child: ElevatedButton(
                child: const Text('Giriş Yap'),
                onPressed: () async {
                  await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              ),
            ),
          );
        }
        final service = FirestoreService();
        return Scaffold(
          appBar: AppBar(title: const Text('Kartlarım'), centerTitle: true),
          body: StreamBuilder<List<CardModel>>(
            stream: service.getCards(user.uid),
            builder: (ctx2, snap2) {
              if (snap2.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final cards = snap2.data ?? [];
              if (cards.isEmpty) {
                return const Center(child: Text('Henüz kart eklenmemiş.'));
              }
              return ListView.builder(
                itemCount: cards.length,
                itemBuilder: (_, i) {
                  final card = cards[i];
                  return ListTile(
                    title: Text(card.label),
                    subtitle: Text(card.number),
                    trailing: Text('${card.balance.toStringAsFixed(2)} ₺'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CardDetailScreen(cardId: card.id),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (_) => const AddCardScreen()),
              );
            },
          ),
        );
      },
    );
  }
}
