import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userData.data()!;
    } else {
      return {
        'nombre': 'Usuario',
        'email': 'usuario@example.com',
        'imageUrl': 'https://via.placeholder.com/150'
      };
    }
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error al cargar los datos del usuario'));
          } else {
            var userData = snapshot.data!;
            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(userData['nombre']),
                  accountEmail: Text(userData['email']),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(userData['imageUrl']),
                    child: userData['imageUrl'] ==
                            'https://via.placeholder.com/150'
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  decoration: BoxDecoration(
                    color: Color(
                        0xFF5008186), // Color de fondo del UserAccountsDrawerHeader
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Inicio"),
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text("Dashboard"),
                  onTap: () {
                    Navigator.pushNamed(context, "/dashboard");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text("Productos"),
                  onTap: () {
                    Navigator.pushNamed(context, "/products");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.receipt),
                  title: const Text("Pedido"),
                  onTap: () {
                    Navigator.pushNamed(context, "/orders");
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Cerrar Sesión"),
                  onTap: () => _signOut(context),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
