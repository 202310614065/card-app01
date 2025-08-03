// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Projenizin kendi dosya yapısına göre DÜZELTİLMİŞ importlar
import '../models/card_model.dart';
import '../services/firestore_service.dart';
import '../utils/auth_utils.dart';
import 'add_card_screen.dart';
import 'routes_screen.dart';
import 'stops_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Kartlar arasında kaydırma yapmak için PageController
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            // GREETING
            _buildGreeting(user),
            const SizedBox(height: 20),
            // CARD CAROUSEL
            _buildCardCarousel(user, theme),
            const SizedBox(height: 30),
            // ACTION GRID
            _buildActionGrid(),
          ],
        ),
      ),
    );
  }

  // Kullanıcı selamlama widget'ı
  Widget _buildGreeting(User? user) {
    final String name = user?.displayName ?? 'Misafir';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Merhaba, $name!',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'VazoKart işlemlerine hoş geldin.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Kaydırılabilir kartlar bölümü
  Widget _buildCardCarousel(User? user, ThemeData theme) {
    return SizedBox(
      height: 210,
      child: user == null
          ? _buildLoginToAddCardPrompt()
          : StreamBuilder<List<CardModel>>(
              stream: FirestoreService().getCards(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Bir hata oluştu.'));
                }
                final cards = snapshot.data ?? [];
                if (cards.isEmpty) {
                  return _buildAddCardPrompt();
                }
                return PageView.builder(
                  controller: _pageController,
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return _CardView(card: card);
                  },
                );
              },
            ),
    );
  }

  // Menü butonlarının olduğu grid yapısı
  Widget _buildActionGrid() {
    final List<Map<String, dynamic>> actions = [
      {'icon': Icons.directions_bus_filled, 'label': 'Otobüsler', 'page': const RoutesScreen()},
      {'icon': Icons.place, 'label': 'Duraklar', 'page': const StopsScreen()},
      {'icon': Icons.add_card, 'label': 'Bakiye Yükle', 'page': null /* TODO: Bakiye Yükleme ekranını ekle */},
      {'icon': Icons.pin_drop, 'label': 'En Yakın Durak', 'page': null /* TODO: En Yakın Durak ekranını ekle */},
      {'icon': Icons.chat_bubble_outline, 'label': 'Şikayet İlet', 'page': null /* TODO: Şikayet ekranını ekle */},
      {'icon': Icons.add_circle_outline, 'label': 'Kart Ekle', 'page': const AddCardScreen()},
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        return _ActionButton(
          icon: action['icon'],
          label: action['label'],
          onTap: () async {
            final user = FirebaseAuth.instance.currentUser;
            final page = action['page'] as Widget?;
            
            bool needsAuth = action['label'] == 'Bakiye Yükle' || action['label'] == 'Kart Ekle';

            if (page != null) {
              if (needsAuth && user == null) {
                await ensureLoggedIn(context);
                if (!context.mounted) return;
                if (FirebaseAuth.instance.currentUser != null) {
                   Navigator.push(context, MaterialPageRoute(builder: (_) => page));
                }
              } else {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => page));
              }
            } else {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${action['label']} özelliği yakında eklenecek.')),
              );
            }
          },
        );
      },
    );
  }

  // Giriş yapılmadıysa kart eklemek için gösterilecek widget
  Widget _buildLoginToAddCardPrompt() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () async {
          await ensureLoggedIn(context);
          if (context.mounted) {
            setState(() {});
          }
        },
        child: _buildPromptContainer('Kartlarınızı görmek için giriş yapın', Icons.login),
      ),
    );
  }

  // Kart yoksa yeni kart eklemek için gösterilecek widget
  Widget _buildAddCardPrompt() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddCardScreen()));
        },
        child: _buildPromptContainer('Yeni Kart Ekle', Icons.add),
      ),
    );
  }

  // Ortak "Kart Ekle/Giriş Yap" kutu tasarımı
  Widget _buildPromptContainer(String text, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 12),
            Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

// Kartın görselini oluşturan widget - cardNumber hatası giderildi.
class _CardView extends StatelessWidget {
  final CardModel card;
  const _CardView({required this.card});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withAlpha(77),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'VazoKart',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
                Icon(Icons.memory, color: Colors.white.withAlpha(204), size: 36),
              ],
            ),
            // Kart Numarası yerine Kart Etiketi (label) gösteriliyor
            Text(
              card.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
            // Bakiye bilgisi
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Bakiye', style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 14)),
                    Text('${card.balance.toStringAsFixed(2)} ₺', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Ana menüdeki aksiyon butonu
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withAlpha(25), spreadRadius: 1, blurRadius: 10)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 10),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
