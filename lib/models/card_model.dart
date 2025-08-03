// lib/models/card_model.dart
class CardModel {
  final String id;
  final String ownerId;
  final String number;
  final String label;
  final double balance;

  CardModel({
    required this.id,
    required this.ownerId,
    required this.number,
    required this.label,
    required this.balance,
  });

  factory CardModel.fromMap(String id, Map<String, dynamic> data) {
    return CardModel(
      id: id,
      ownerId: data['ownerId'] ?? '',
      number: data['number'] ?? '---',
      label: data['label'] ?? '',
      balance: (data['balance'] ?? 0.0).toDouble(),
    );
  }

  // Veritabanına eklemek için
  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'number': number,
      'label': label,
      'balance': balance,
    };
  }
}
