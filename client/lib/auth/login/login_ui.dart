import 'package:client/constants.dart';
import 'package:client/home/homePage.dart';
import 'package:flutter/material.dart';
import 'authService.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppbar(context, title: 'Login'),
      body: Center(
        child: RaisedButton(
              child: Text('Login with Google'),
              onPressed: () async {
                AuthService().signIn().then((result){
                  if(result!=null){
                    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => new HomePage()));
                  }
                });
              },
            ),
      ),
    );
  }
}