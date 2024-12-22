import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:neighborgood/common/provider/storage_reposiotry.dart';
import 'package:neighborgood/features/auth/repository/auth_gate.dart';
import 'package:neighborgood/features/auth/repository/auth_repository.dart';
import 'package:neighborgood/features/posts/repository/post_repository.dart';
import 'package:neighborgood/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AuthRepository(
            auth: FirebaseAuth.instance,
          ),
        ),
        Provider(
          create: (context) => PostRepository(),
        ),
        Provider(
          create: (context) => StorageRepository(
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Neighborgood',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const AuthGate(),
      ),
    );
  }
}
