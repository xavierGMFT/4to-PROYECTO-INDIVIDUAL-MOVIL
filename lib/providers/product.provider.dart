import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createProduct({
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required String category,
    required int stock,
  }) async {
    try {
      await _firestore.collection('products').add({
        'nombre': name,
        'descripcion': description,
        'precio': price,
        'imagenURL': imageUrl,
        'categoria': category,
        'stock': stock,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection('products').doc(productId).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
