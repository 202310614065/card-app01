import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'root_page.dart'; // Çıkış yapınca ana sayfaya dön

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Eğer bir şekilde bu ekrana giriş yapmamış bir kullanıcı gelirse
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("Kullanıcı bulunamadı."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesabım"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profil bilgileri kartı
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.displayName ?? "Kullanıcı Adı",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email ?? "E-posta adresi yok",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Ayarlar ve diğer seçenekler
          _buildProfileMenuItem(
            context,
            icon: Icons.notifications_outlined,
            text: "Bildirimler",
            onTap: () {},
          ),
          _buildProfileMenuItem(
            context,
            icon: Icons.security_outlined,
            text: "Güvenlik",
            onTap: () {},
          ),
          _buildProfileMenuItem(
            context,
            icon: Icons.help_outline,
            text: "Yardım & Destek",
            onTap: () {},
          ),
          const Divider(),
          
          // Çıkış Yap butonu
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text("Çıkış Yap", style: TextStyle(color: Colors.redAccent)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const RootPage()),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Profil menü elemanlarını oluşturan yardımcı widget
  Widget _buildProfileMenuItem(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(text, style: Theme.of(context).textTheme.bodyLarge),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
