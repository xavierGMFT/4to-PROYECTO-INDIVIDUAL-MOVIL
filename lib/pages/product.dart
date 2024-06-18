import 'package:flutter/material.dart';
import 'package:prueba_base/pages/categorias/ver_categorias.dart';


class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: CategoriesViewPage(), // Mostramos las categorías
    );
  }
}
