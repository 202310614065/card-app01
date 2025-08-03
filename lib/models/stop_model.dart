// lib/models/stop_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Stop {
  final String id;
  final String name;
  final GeoPoint location;

  Stop({required this.id, required this.name, required this.location});

  factory Stop.fromMap(String id, Map<String, dynamic> data) {
    return Stop(
      id: id,
      name: data['name'] ?? '',
      location: data['location'] ?? GeoPoint(0, 0),
    );
  }
}