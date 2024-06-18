import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductPage extends StatefulWidget {
  final String productId;
  final Map<String, dynamic> productData;

  EditProductPage(this.productId, this.productData);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;
  late TextEditingController _stockController;
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productData['nombre']);
    _descriptionController = TextEditingController(text: widget.productData['descripcion']);
    _priceController = TextEditingController(text: widget.productData['precio'].toString());
    _imageUrlController = TextEditingController(text: widget.productData['imagenURL']);
    _stockController = TextEditingController(text: widget.productData['stock'].toString());
    _selectedCategoryId = widget.productData['categoriaId'];
  }

  void _updateProduct() async {
    if (_nameController.text.isNotEmpty && _selectedCategoryId != null) {
      await FirebaseFirestore.instance.collection('products').doc(widget.productId).update({
        'nombre': _nameController.text,
        'descripcion': _descriptionController.text,
        'precio': double.parse(_priceController.text),
        'imagenURL': _imageUrlController.text,
        'categoriaId': _selectedCategoryId,
        'stock': int.parse(_stockController.text),
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'URL de la imagen'),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  var categories = snapshot.data!.docs;
                  return DropdownButtonFormField<String>(
                    value: _selectedCategoryId,
                    hint: Text('Seleccionar Categoría'),
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category.id,
                        child: Text(category['nombre']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategoryId = value;
                      });
                    },
                  );
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text('Actualizar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
