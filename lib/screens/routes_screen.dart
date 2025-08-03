// lib/screens/routes_screen.dart
import 'package:flutter/material.dart';
import '../models/route_model.dart';
import '../services/firestore_service.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('Otobüs Hatları')),
      body: StreamBuilder<List<BusRoute>>(
        stream: firestoreService.getRoutes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Hiç hat bulunamadı.'));
          }
          final routes = snapshot.data!;
          return ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) {
              final route = routes[index];
              return ListTile(
                leading: const Icon(Icons.directions_bus),
                title: Text(route.name),
                onTap: () {
                  // TODO: Hat detay sayfasına git
                },
              );
            },
          );
        },
      ),
    );
  }
}