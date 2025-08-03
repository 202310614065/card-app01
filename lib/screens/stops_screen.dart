// lib/screens/stops_screen.dart
import 'package:flutter/material.dart';
import '../models/stop_model.dart';
import '../services/firestore_service.dart';

class StopsScreen extends StatelessWidget {
  const StopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('Duraklar')),
      body: StreamBuilder<List<Stop>>(
        stream: firestoreService.getStops(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Hiç durak bulunamadı.'));
          }
          final stops = snapshot.data!;
          return ListView.builder(
            itemCount: stops.length,
            itemBuilder: (context, index) {
              final stop = stops[index];
              return ListTile(
                leading: const Icon(Icons.place),
                title: Text(stop.name),
                subtitle: Text('Konum: ${stop.location.latitude}, ${stop.location.longitude}'),
              );
            },
          );
        },
      ),
    );
  }
}