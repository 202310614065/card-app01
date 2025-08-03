// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/card_model.dart';
import '../models/stop_model.dart';
import '../models/route_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Kartları getir
  Stream<List<CardModel>> getCards(String userId) {
    return _db
        .collection('cards')
        .where('ownerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CardModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Kart ekleme
  Future<void> addCard(CardModel card) {
    return _db.collection('cards').add(card.toMap());
  }

  // Durakları getir
  Stream<List<Stop>> getStops() {
    return _db.collection('stops').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Stop.fromMap(doc.id, doc.data())).toList());
  }

  // Hatları (Rotaları) getir
  Stream<List<BusRoute>> getRoutes() {
    return _db.collection('routes').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => BusRoute.fromMap(doc.id, doc.data()))
        .toList());
  }
}