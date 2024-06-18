import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCategoryPage extends StatefulWidget {
  final String categoryId;
  final String initialName;

  EditCategoryPage(this.categoryId, this.initialName);

  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController(text: widget.initialName);
  }

  void _updateCategory() async {
    if (_categoryController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('categories').doc(widget.categoryId).update({
        'nombre': _categoryController.text,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Categoría')),
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
              onPressed: _updateCategory,
              child: Text('Actualizar Categoría'),
            ),
          ],
        ),
      ),
    );
  }
}
