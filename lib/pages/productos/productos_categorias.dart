import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsByCategoryPage extends StatefulWidget {
  final String categoryId;

  ProductsByCategoryPage({required this.categoryId});

  @override
  _ProductsByCategoryPageState createState() => _ProductsByCategoryPageState();
}

class _ProductsByCategoryPageState extends State<ProductsByCategoryPage> {
  Map<String, int> cart = {};

  void addToCart(String productId, int stock) {
    setState(() {
      if (cart.containsKey(productId)) {
        if (cart[productId]! < stock) {
          cart[productId] = cart[productId]! + 1;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Stock insuficiente')),
          );
        }
      } else {
        if (stock > 0) {
          cart[productId] = 1;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Stock insuficiente')),
          );
        }
      }
    });
  }

  void removeFromCart(String productId) {
    setState(() {
      if (cart.containsKey(productId) && cart[productId]! > 1) {
        cart[productId] = cart[productId]! - 1;
      } else {
        cart.remove(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Productos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('categoriaId', isEqualTo: widget.categoryId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final products = snapshot.data!.docs;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              var productId = product.id;
              var stock = product['stock'];
              return ListTile(
                leading: Image.network(
                  product['imagenURL'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product['nombre']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Descripción: ${product['descripcion']}'),
                    Text('Precio: \$${product['precio']}'),
                    Text('Stock: ${product['stock']}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => removeFromCart(productId),
                    ),
                    Text(cart[productId]?.toString() ?? '0'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => addToCart(productId, stock),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart', arguments: cart);
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
