// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neighborgood/common/utils/show_snackbar.dart';
import 'package:neighborgood/features/auth/screens/login_screen.dart';
import 'package:neighborgood/features/home/screens/entry_point.dart';
import 'package:neighborgood/modals/user.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  AuthRepository(
    this._auth,
  );

  User get user => _auth.currentUser!;

  String get currentUid => _auth.currentUser!.uid;

  Stream<User?> get authState => _auth.authStateChanges();

  CollectionReference get _users =>
      FirebaseFirestore.instance.collection('users');

  Future<void> loginUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const EntryPoint(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required BuildContext context,
    required String name,
  }) async {
    try {
      print("hello");
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
      );
      _users.doc(userCredential.user!.uid).set(userModel.toMap());
      if (userCredential.user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const EntryPoint(),
          ),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(context, e.message!);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        DocumentSnapshot userDoc =
            await _users.doc(userCredential.user!.uid).get();

        if (!userDoc.exists) {
          // If the user doesn't exist, create a new user document
          UserModel newUser = UserModel(
            uid: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? "No name",
            email: userCredential.user!.email!,
          );

          await _users.doc(newUser.uid).set(newUser.toMap());
          print('New user created: ${newUser.name}');
        } else {
          // If the user exists, retrieve their data
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          UserModel existingUser = UserModel.fromMap(userData);
          print('Existing user signed in: ${existingUser.name}');
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred')));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        context,
        e.message!,
      );
    }
  }
}
