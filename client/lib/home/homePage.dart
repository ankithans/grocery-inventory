import 'dart:io';

import 'package:client/auth/login/authService.dart';
import 'package:client/auth/login/login_ui.dart';
import 'package:client/constants.dart';
import 'package:client/displaySuggestions/displaySuggestions.dart';
import 'package:client/home/homePageServices.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File image;
  final picker = ImagePicker();

  Future getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if(pickedFile != null){
      setState(() {
        image = File(pickedFile.path);
      });
    }

  }

  Future getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      setState(() {
        image = File(pickedFile.path);
      });
    }

  }


  Future getImage(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Let\'s get scanning'),
          content: Text('Capture item with camera or pick from gallery'),
          actions: [
            FlatButton(
              child: Text('Camera'),
              onPressed: () async {
                await getCameraImage();
                Navigator.pop(context);
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new DisplaySuggestionsPage(image: image),));
              },
            ),
            FlatButton(
              child: Text('Gallery'),
              onPressed: () async {
                await getGalleryImage();
                Navigator.pop(context);
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new DisplaySuggestionsPage(image: image),));
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
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
      floatingActionButton: FloatingActionButton(
        heroTag: 'snapPic',
        child: Icon(Icons.camera_alt_outlined, color: backgroundColor,),
        backgroundColor: primaryColor,
        onPressed: () {
          getImage(_scaffoldKey.currentContext);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}