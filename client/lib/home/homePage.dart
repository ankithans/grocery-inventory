import 'dart:io';

import 'package:client/auth/login/authService.dart';
import 'package:client/auth/login/login_ui.dart';
import 'package:client/constants.dart';
import 'package:client/displaySuggestions/displaySuggestions.dart';
import 'package:client/home/homePageServices.dart';
import 'package:client/widget/homePageItem.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  File image;
  final picker = ImagePicker();

  Future getItems;

  Future getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future getImage(BuildContext context) async {
    return showDialog(
      context: _scaffoldKey.currentContext,
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
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) =>
                          new DisplaySuggestionsPage(image: image),
                    ));
              },
            ),
            FlatButton(
              child: Text('Gallery'),
              onPressed: () async {
                await getGalleryImage();
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) =>
                          new DisplaySuggestionsPage(image: image),
                    ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getItems = HomeServices().getList(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: titleAppbar(
        context, 
        title: 'Home',
        actions: [
          FlatButton(
            child: Icon(Icons.exit_to_app, color: backgroundColor,),
            onPressed: () async {
              await AuthService().signOut(context);
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginPage()));
            },
          ),
        ]
      ),
      body: FutureBuilder(
        future: getItems,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data['grocery'].length,
              itemBuilder: (context, index) {
                return HomePageItemCard(
                  title: snapshot.data['grocery'][index]['tag'],
                  subtitle: snapshot.data['grocery'][index]['finished'] == false ? Icon(Icons.check, color: Colors.green) : Icon(Icons.cancel_outlined, color: Colors.red,), 
                  onPressed: (){}, 
                  trailing: Icons.arrow_circle_down_rounded, 
                  imageUrl: snapshot.data['grocery'][index]['image']
                );
              },
            );
          }
          else{
            return Center(
              child: LoadingFlipping.square(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'snapPic',
        child: Icon(
          Icons.camera_alt_outlined,
          color: backgroundColor,
        ),
        backgroundColor: primaryColor,
        onPressed: () {
          getImage(_scaffoldKey.currentContext);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
