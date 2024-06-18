// add_category.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController _categoryController = TextEditingController();

  void _addCategory() async {
    if (_categoryController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('categories').add({
        'nombre': _categoryController.text,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Añadir Categoría')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Nombre de Categoría'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCategory,
              child: Text('Añadir Categoría'),
            ),
          ],
        ),
      ),
    );
  }
}
