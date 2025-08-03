// lib/screens/add_card_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';
import '../models/card_model.dart';
import '../utils/auth_utils.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String label = '';
  String number = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kart Ekle')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Kart Adı'),
                validator: (v) => v == null || v.isEmpty ? 'Boş geçilemez' : null,
                onChanged: (v) => label = v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Kart Numarası'),
                keyboardType: TextInputType.number,
                validator: (v) => v != null && v.length >= 8 ? null : 'En az 8 hane',
                onChanged: (v) => number = v,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: loading ? null : _saveCard,
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveCard() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { loading = true; });
    try {
      final auth = FirebaseAuth.instance;
      var user = auth.currentUser;
      if (user == null) {
        final loggedIn = await ensureLoggedIn(context);
        if (!loggedIn) {
          return;
        }
        user = auth.currentUser;
      }

      final newCard = CardModel(
        id: '',
        ownerId: user!.uid,
        number: number,
        label: label,
        balance: 0.0,
      );
      await FirestoreService().addCard(newCard);
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Kart ekleme hatası')));
    } finally {
      if (mounted) setState(() { loading = false; });
    }
  }
}
