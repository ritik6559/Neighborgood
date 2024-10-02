import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neighborgood/features/auth/screens/login_screen.dart';
import 'package:neighborgood/features/home/screens/entry_point.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const EntryPoint();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
