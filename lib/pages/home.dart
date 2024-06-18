import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_base/widgets/navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, dynamic>> getUserData() async {
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

  @override
  Widget build(BuildContext context) {
    List<String> imgList = [
      'assets/images/promo1.jpg',
      'assets/images/promo2.jpg',
      'assets/images/promo3.jpg',
      'assets/images/promo4.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const NavBar(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error al cargar los datos del usuario'));
          } else {
            var userData = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/portada.jpg', // URL de la imagen principal
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mi Tiendita App',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Conocoto',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Horario de Atención: 8:00 - 22:30',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Bienvenido ${userData['nombre']}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Promociones',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                    ),
                    items: imgList
                        .map((item) => Container(
                              child: Center(
                                child: Image.asset(
                                  item,
                                  fit: BoxFit.cover,
                                  width: 1000,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
