// lib/models/bus_model.dart
class Bus {
  final String id;
  final String plate; // Plaka
  final String model;

  Bus({required this.id, required this.plate, required this.model});

  factory Bus.fromMap(String id, Map<String, dynamic> data) {
    return Bus(
      id: id,
      plate: data['plate'] ?? '',
      model: data['model'] ?? '',
    );
  }
}