import 'package:client/auth/login/authService.dart';
import 'package:client/auth/login/login_ui.dart';
import 'package:client/constants.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppbar(
        context, 
        title: 'Home',
        actions: [
          FlatButton(
            child: Icon(Icons.exit_to_app, color: backgroundColor,),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginPage()));
            },
          ),
        ]
      ),
    );
  }
}