// lib/screens/discover_screen.dart
import 'package:flutter/material.dart';
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keşfet'), centerTitle: true),
      body: const Center(child: Text('Keşfet içeriği burada')),
    );
  }
}
