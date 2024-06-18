import 'package:flutter/material.dart';
import 'package:prueba_base/pages/categorias/add_category.dart';
import 'package:prueba_base/pages/categorias/edit_category.dart';
import 'package:prueba_base/pages/categorias/view_categories.dart';
import 'package:prueba_base/pages/dashboard.dart';
import 'package:prueba_base/pages/home.dart';
import 'package:prueba_base/pages/login.dart';
import 'package:prueba_base/pages/order.dart';
import 'package:prueba_base/pages/product.dart';
import 'package:prueba_base/pages/productos/add_product.dart';
import 'package:prueba_base/pages/productos/edit_product.dart';
import 'package:prueba_base/pages/productos/productos_categorias.dart';
import 'package:prueba_base/pages/productos/view_products.dart';
import 'package:prueba_base/pages/register.dart';
import 'package:prueba_base/pages/splash.dart';
import 'package:prueba_base/pages/usuarios/view_users.dart';
import 'package:prueba_base/widgets/cart_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  '/splash': (_) => const SplashPage(),
  '/login': (_) => const LoginPage(),
  '/register': (_) => const RegisterPage(),
  '/home': (_) => const HomePage(),
  '/products': (_) => const ProductsPage(),
  '/orders': (_) => const OrderPage(),
  '/add_product': (_) => AddProductPage(),
  '/dashboard': (_) => DashboardPage(),
  '/add_category': (_) => AddCategoryPage(),
  '/edit_category': (context) => EditCategoryPage('', ''), // Ruta de ejemplo
  '/edit_product': (context) => EditProductPage('', {}), // Ruta de ejemplo
  '/view_users': (_) => ViewUsersPage(),
  '/view_categories': (_) => ViewCategoriesPage(),
  '/view_products': (_) => ViewProductsPage(),
  '/productos_categorias': (context) => ProductsByCategoryPage(categoryId: ''),
  '/cart': (context) => CartPage(
      cart: ModalRoute.of(context)!.settings.arguments as Map<String, int>),
};
