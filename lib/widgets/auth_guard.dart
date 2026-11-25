import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

/// Ensures the user is authenticated, pushing [LoginScreen] when needed.
Future<bool> ensureLoggedIn(BuildContext context) async {
  final authState = context.read<AuthState>();

  if (authState.isLoggedIn) {
    return true;
  }

  // Jika belum login, open LoginScreen.
  final loggedIn = await Navigator.push<bool>(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginScreen(),
    ),
  );

  return loggedIn ?? false;
}