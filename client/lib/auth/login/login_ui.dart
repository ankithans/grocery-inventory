import 'package:auth_buttons/auth_buttons.dart';
import 'package:client/constants.dart';
import 'package:client/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'authService.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppbar(context, title: 'Login'),
      body: Center(
        child: _loading == true
            ? LoadingJumpingLine.square(
                backgroundColor: primaryColor,
              )
            : GoogleAuthButton(
                onPressed: () {
                  setState(() {
                    _loading = true;
                  });
                  AuthService().signIn(context).then((result) {
                    if (result != null) {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new HomePage()));
                    }
                  });
                  setState(() {
                    _loading = false;
                  });
                },
                darkMode: false,
              ),
      ),
    );
  }
}
