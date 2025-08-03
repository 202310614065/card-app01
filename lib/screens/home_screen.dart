// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'routes_screen.dart'; // Yeni import
import 'stops_screen.dart';  // Yeni import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.search, 'label': 'Otobüs / Durak Ara', 'page': const SearchScreen()},
      {'icon': Icons.directions_bus, 'label': 'Tüm Hatlar', 'page': const RoutesScreen()}, // Yeni eklendi
      {'icon': Icons.place, 'label': 'Tüm Duraklar', 'page': const StopsScreen()}, // Yeni eklendi
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item['page'] as Widget)),
              borderRadius: BorderRadius.circular(12),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'] as IconData, size: 40),
                    const SizedBox(height: 8),
                    Text(item['label'] as String, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}