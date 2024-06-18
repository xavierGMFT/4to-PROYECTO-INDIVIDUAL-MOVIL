import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loginUser({
    required String email,
    required String password,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Utiliza la variable userCredential si es necesario, por ejemplo:
      User? user = userCredential.user;
      if (user != null) {
        // Realiza alguna acción con el usuario
      }
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message!);
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String username,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'username': username,
          'email': email,
          'imageUrl': '',
          'fechaRegistro': FieldValue.serverTimestamp(),
        });
      }
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message!);
    }
  }
}
