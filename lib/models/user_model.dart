// lib/models/user_model.dart
class AppUser {
  final String uid;
  final String? email;
  // İleride eklenebilecek diğer kullanıcı bilgileri
  // final String name;
  // final String phoneNumber;

  AppUser({required this.uid, this.email});
}