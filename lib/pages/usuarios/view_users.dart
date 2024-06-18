import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewUsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Usuarios')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              return ListTile(
                title: Text(user['nombre']),
                subtitle: Text(user['email']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
