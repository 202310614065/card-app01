import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'profile_screen.dart'; // Profil ekranı için yeni dosya

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Kullanıcı giriş yapmamışsa uyarı gösterip giriş ekranına yönlendiren metot
  void _showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text("Giriş Gerekli", style: Theme.of(context).textTheme.headlineMedium),
          content: Text("Bu özelliği kullanabilmek için giriş yapmanız gerekmektedir.", style: Theme.of(context).textTheme.bodyMedium),
          actions: <Widget>[
            TextButton(
              child: const Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("Giriş Yap"),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        );
      },
    );
  }

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
              onPressed: () {
                if (user != null) {
                  // Giriş yapılmışsa profil ekranına git
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                } else {
                  // Giriş yapılmamışsa giriş ekranına git
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
              Text(
                'Hoş Geldiniz,',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
              ),
              Text(
                user?.displayName ?? 'Gezgin',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 24),
              // Ana menü butonları
              _buildFeatureGrid(context, user),
            ],
          ),
        ),
      ),
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
          onTap: () {
            // Eğer özellik giriş gerektiriyorsa ve kullanıcı giriş yapmamışsa
            if (feature['auth_required'] as bool && user == null) {
              _showLoginRequiredDialog(context);
            } else {
              // TODO: İlgili sayfaya yönlendirme yapılacak.
              // Örnek: if (feature['label'] == 'Kartlarım') Navigator.push(...);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${feature['label']} sayfasına gidiliyor...')),
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // TODO: Giriş işlemini burada yapın
          },
          child: const Text('Giriş Yap'),
        ),
      ),
    );
  }
}
