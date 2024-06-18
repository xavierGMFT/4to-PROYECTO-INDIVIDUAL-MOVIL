import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getUsers() async {
  List<Map<String, dynamic>> users = [];
  CollectionReference collectionReferenceUsers = db.collection("users");

  try {
    QuerySnapshot queryUsers = await collectionReferenceUsers.get();
    queryUsers.docs.forEach((document) {
      users.add(document.data() as Map<String, dynamic>);
    });
  } catch (e) {
    print("Error al obtener usuarios: $e");
  }

  return users;
}

Future<List<Map<String, dynamic>>> getProducts() async {
  List<Map<String, dynamic>> products = [];
  CollectionReference collectionReferenceProducts = db.collection("products");

  try {
    QuerySnapshot queryProducts = await collectionReferenceProducts.get();
    queryProducts.docs.forEach((document) {
      products.add(document.data() as Map<String, dynamic>);
    });
  } catch (e) {
    print("Error al obtener productos: $e");
  }

  return products;
}
