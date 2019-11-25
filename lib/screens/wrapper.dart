import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zokor_logger/models/user.dart';
import 'package:zokor_logger/screens/authenticate/authenticate.dart';
import 'package:zokor_logger/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
