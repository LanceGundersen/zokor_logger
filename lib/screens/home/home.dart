import 'package:flutter/material.dart';
import 'package:zokor_logger/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
            title: Text('Zokor Logger'),
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
