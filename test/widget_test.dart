// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:card_app/main.dart';
import 'package:card_app/screens/login_screen.dart';

void main() {
  // NOT: Bu testin çalışması için firebase_core'un sahte (mock) bir versiyonunun
  // ayarlanması gerekir. Bu, basit bir UI doğrulama testidir.
  testWidgets('App starts and shows LoginScreen when not authenticated', (WidgetTester tester) async {
    // Uygulamayı başlat ve bir frame oluştur.
    // Gerçek Firebase'i başlatmadan test etmek için main() içindeki
    // Firebase.initializeApp() çağrısını yorum satırına almanız gerekebilir.
    await tester.pumpWidget(const VazoKartApp());

    // Yükleme göstergesinin (CircularProgressIndicator) kaybolmasını bekle.
    await tester.pumpAndSettle();

    // AuthWrapper'ın, kullanıcı giriş yapmadığı için LoginScreen'i göstermesini bekle.
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Giriş Yap'), findsWidgets);
  });
}