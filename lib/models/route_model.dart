// lib/models/route_model.dart
class BusRoute {
  final String id;
  final String name;
  final List<String> stopIds; // Durakların ID'leri

  BusRoute({required this.id, required this.name, required this.stopIds});

  factory BusRoute.fromMap(String id, Map<String, dynamic> data) {
    return BusRoute(
      id: id,
      name: data['name'] ?? '',
      stopIds: List<String>.from(data['stopIds'] ?? []),
    );
  }
}