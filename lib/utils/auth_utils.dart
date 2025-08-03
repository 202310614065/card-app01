import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';

/// Ensures the user is authenticated.
///
/// If the user is not logged in, navigates to [LoginScreen].
/// Returns `true` if the user is authenticated after the call.
Future<bool> ensureLoggedIn(BuildContext context) async {
  if (FirebaseAuth.instance.currentUser != null) {
    return true;
  }
  final result = await Navigator.push<bool>(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
  );
  return result == true;
}
