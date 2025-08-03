// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_screen.dart'; // Profil ekranı için yeni dosya
import '../utils/auth_utils.dart';
import '../services/firestore_service.dart';
import '../models/card_model.dart';
import 'cards_screen.dart';
import 'stops_screen.dart';
import 'routes_screen.dart';
import 'search_screen.dart';
import 'add_card_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('VazoKart Mobil', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          // Kullanıcının giriş durumuna göre buton göster
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              icon: Icon(
                user != null ? Icons.person_outline : Icons.login,
                size: 20,
              ),
              label: Text(user != null ? 'Hesabım' : 'Giriş Yap'),
              onPressed: () async {
                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                } else {
                  await ensureLoggedIn(context);
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onBackground,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardSection(context, user),
              const SizedBox(height: 24),
              _buildFeatureGrid(context, user),
            ],
          ),
        ),
      ),
    );
  }

  // Kartlarımı listeleyen bölüm
  Widget _buildCardSection(BuildContext context, User? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kartlarım', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        if (user == null)
          const Text('Kartlarınızı görmek için giriş yapın.')
        else
          SizedBox(
            height: 120,
            child: StreamBuilder<List<CardModel>>(
              stream: FirestoreService().getCards(user.uid),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final cards = snap.data ?? [];
                if (cards.isEmpty) {
                  return const Center(child: Text('Henüz kart eklenmemiş.'));
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: cards.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) {
                    final card = cards[i];
                    return Container(
                      width: 200,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(card.label,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white)),
                          Text('${card.balance.toStringAsFixed(2)} ₺',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.white)),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  // Ana ekrandaki işlev kartlarını oluşturan widget
  Widget _buildFeatureGrid(BuildContext context, User? user) {
    final features = [
      {'icon': Icons.credit_card, 'label': 'Kartlarım', 'auth_required': true},
      {'icon': Icons.pin_drop_outlined, 'label': 'Duraklar', 'auth_required': false},
      {'icon': Icons.directions_bus_filled_outlined, 'label': 'Otobüsler', 'auth_required': false},
      {'icon': Icons.map_outlined, 'label': 'En Yakın Durak', 'auth_required': false},
      {'icon': Icons.add_card_outlined, 'label': 'Bakiye Yükle', 'auth_required': true},
      {'icon': Icons.support_agent_outlined, 'label': 'Şikayet İlet', 'auth_required': true},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return _FeatureCard(
          icon: feature['icon'] as IconData,
          label: feature['label'] as String,
          onTap: () async {
            if (feature['auth_required'] as bool && user == null) {
              final ok = await ensureLoggedIn(context);
              if (!ok) return;
            }
            switch (feature['label']) {
              case 'Kartlarım':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CardsScreen()),
                );
                break;
              case 'Duraklar':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StopsScreen()),
                );
                break;
              case 'Otobüsler':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RoutesScreen()),
                );
                break;
              case 'En Yakın Durak':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()),
                );
                break;
              case 'Bakiye Yükle':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddCardScreen()),
                );
                break;
              default:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${feature['label']} henüz hazır değil')), 
                );
            }
          },
        );
      },
    );
  }
}

// Tek bir işlev kartını temsil eden widget
class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}