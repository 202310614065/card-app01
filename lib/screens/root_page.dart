// lib/screens/root_page.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'cards_screen.dart';
import 'qr_screen.dart';
import 'transactions_screen.dart';
import 'discover_screen.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  static const _pages = [
    HomeScreen(),
    CardsScreen(),
    QrScreen(),
    TransactionsScreen(),
    DiscoverScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Kartlarım'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'İşlemler'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Keşfet'),
        ],
      ),
    );
  }
}
