// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.search, 'label': 'Otobüs / Durak Ara', 'page': const SearchScreen()},
    ]; // <-- Added missing closing bracket here

    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: items.map((it) {
            return InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => it['page'] as Widget)),
              borderRadius: BorderRadius.circular(12),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(it['icon'] as IconData, size: 40),
                    const SizedBox(height: 8),
                    Text(it['label'] as String, textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
