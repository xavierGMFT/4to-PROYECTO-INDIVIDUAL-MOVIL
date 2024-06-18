import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
    required String direccion,
    required String telefono,
    required String imageUrl,
    required Timestamp fechaRegistro,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'nombre': name,
        'email': email,
        'direccion': direccion,
        'telefono': telefono,
        'imageUrl': imageUrl,
        'fechaRegistro': fechaRegistro,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
    } catch (e) {
      rethrow;
    }
  }
}
