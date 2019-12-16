import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Home extends StatelessWidget {
  final CollectionReference taskCollection;
  final AuthService _authService = AuthService();

  Home() : taskCollection = firestore().collection('tasks');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
            title: Text('Hello'),
            backgroundColor: Colors.black12,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Logoout'),
                onPressed: () async {
                  await _authService.signOut();
                },
              )
            ]),
      ),
    );
  }
}
