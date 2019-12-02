import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:provider/provider.dart';
import 'package:zokor_logger/screens/wrapper.dart';
import 'package:zokor_logger/services/auth.dart';
import 'package:zokor_logger/models/user.dart';

void main() {
  if (fb.apps.isEmpty) {
    fb.initializeApp(
      apiKey: "AIzaSyB3jeqrTHWiJv7O9QH-5KA6CYPGRrmbkTA",
      authDomain: "zokor-logger.firebaseapp.com",
      databaseURL: "https://zokor-logger.firebaseio.com",
      projectId: "zokor-logger",
      storageBucket: "zokor-logger.appspot.com",
      // messagingSenderId: "735183944889",
    );
  }
  runApp(AppInjector());
}

class AppInjector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
