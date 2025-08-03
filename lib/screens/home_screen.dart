import 'package:flutter/material.dart';
// EKLENDİ: Hareketli menü widget'ının bulunduğu dosyayı import ediyoruz.
import 'package:card_app/widgets/animated_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  // EKLENDİ: İyi pratikler için constructor'a key ekliyoruz.
  const HomeScreen({super.key});

  @override
  // DÜZELTİLDİ: State class'ını public yapmak için alt tire (_) kaldırıldı.
  State<HomeScreen> createState() => HomeScreenState();
}

// DÜZELTİLDİ: State class'ı public yapıldı.
class HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Center(child: Text('Ana Sayfa İçeriği', style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text('Harita İçeriği', style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text('Geçmiş İçeriği', style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text('Profil İçeriği', style: TextStyle(color: Colors.white, fontSize: 24))),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VazoKartlarım', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_card, color: Colors.white),
            onPressed: () {
              // TODO: Kart ekleme ekranına git
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        // DÜZELTİLDİ: 'children' parametresi sona alındı.
        children: _screens, 
      ),
      // Artık AnimatedBottomNavBar tanınıyor.
      bottomNavigationBar: AnimatedBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}