import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los pedidos'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay pedidos disponibles'));
          } else {
            final orders = snapshot.data!.docs;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                var orderData = order.data() as Map<String, dynamic>;
                var products = orderData['productos'] as List<dynamic>;
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Pedido: ${order.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Estado: ${orderData['estado']}'),
                        Text('Total: \$${orderData['total']}'),
                        const SizedBox(height: 10),
                        Text('Productos:'),
                        for (var product in products)
                          Text(
                              '- ${product['nombre']} (x${product['cantidad']})'),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Lógica para eliminar el pedido
                        FirebaseFirestore.instance
                            .collection('orders')
                            .doc(order.id)
                            .delete();
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
