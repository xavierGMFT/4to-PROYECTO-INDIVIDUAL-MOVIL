import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> register(String name, String email, String password, String? imageUrl) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user!;
      await user.updateProfile(displayName: name, photoURL: imageUrl);

      // Save additional user info to Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'nombre': name,
        'email': email,
        'imageUrl': imageUrl,
        'fechaRegistro': DateTime.now().toIso8601String(),
      });

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> uploadImageToStorage(File image) async {
    try {
      String fileName = '${_auth.currentUser!.uid}.jpg';
      Reference ref = _storage.ref().child('user_images').child(fileName);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e);
      return '';
    }
  }
}
