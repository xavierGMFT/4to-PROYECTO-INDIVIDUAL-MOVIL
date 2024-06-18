import 'package:flutter/material.dart';
import 'package:prueba_base/pages/categorias/view_categories.dart';
import 'package:prueba_base/pages/productos/view_products.dart';
import 'package:prueba_base/pages/usuarios/view_users.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color(0xFF008186), // Color del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDashboardButton(
              context,
              icon: Icons.people,
              text: 'Ver Usuarios',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewUsersPage()),
                );
              },
            ),
            SizedBox(height: 16), // Espacio entre botones
            _buildDashboardButton(
              context,
              icon: Icons.category,
              text: 'Ver Categorías',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewCategoriesPage()),
                );
              },
            ),
            SizedBox(height: 16), // Espacio entre botones
            _buildDashboardButton(
              context,
              icon: Icons.shopping_basket,
              text: 'Ver Productos',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewProductsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardButton(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF01545D), // Color de fondo del botón
        foregroundColor: Colors.white, // Color del texto e ícono del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Bordes curvados
        ),
        padding: EdgeInsets.symmetric(vertical: 20), // Padding vertical
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30), // Ícono del botón
          SizedBox(width: 10), // Espacio entre ícono y texto
          Text(
            text,
            style: TextStyle(fontSize: 20), // Tamaño del texto
          ),
        ],
      ),
    );
  }
}
