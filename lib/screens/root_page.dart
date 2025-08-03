// lib/screens/root_page.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'cards_screen.dart';
import 'qr_screen.dart';
import 'transactions_screen.dart';
import 'discover_screen.dart';
import '../widgets/animated_bottom_nav_bar.dart';

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
      bottomNavigationBar: AnimatedBottomNavBar(
        selectedIndex: _currentIndex,
        onItemTapped: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
