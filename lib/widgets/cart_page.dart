import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartPage extends StatefulWidget {
  final Map<String, int> cart;

  CartPage({required this.cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double total = 0;

  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  void calculateTotal() async {
    double tempTotal = 0;
    for (var entry in widget.cart.entries) {
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(entry.key)
          .get();
      var productData = productSnapshot.data() as Map<String, dynamic>;
      tempTotal += productData['precio'] * entry.value;
    }
    setState(() {
      total = tempTotal;
    });
  }

  void createOrder() async {
    User? user = FirebaseAuth.instance.currentUser;
    List<Map<String, dynamic>> products = [];
    for (var entry in widget.cart.entries) {
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(entry.key)
          .get();
      var productData = productSnapshot.data() as Map<String, dynamic>;
      products.add({
        'productId': entry.key,
        'nombre': productData['nombre'],
        'cantidad': entry.value,
        'precio': productData['precio'],
      });
    }
    await FirebaseFirestore.instance.collection('orders').add({
      'estado': 'pendiente',
      'fechaPedido': DateTime.now(),
      'productos': products,
      'total': total,
      'uid': user?.uid,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrito de Compras')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: widget.cart.entries.map((entry) {
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('products')
                      .doc(entry.key)
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    var productData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return ListTile(
                      leading: Image.network(
                        productData['imagenURL'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(productData['nombre']),
                      subtitle: Text('Cantidad: ${entry.value}'),
                      trailing: Text(
                          'Precio: \$${productData['precio'] * entry.value}'),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total: \$${total.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: createOrder,
                  child: Text('Realizar Pedido'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
