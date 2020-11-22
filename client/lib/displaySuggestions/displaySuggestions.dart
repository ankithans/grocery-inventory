import 'dart:io';

import 'package:client/auth/login/tokenService.dart';
import 'package:client/constants.dart';
import 'package:client/displaySuggestions/suggestionsServices.dart';
import 'package:client/home/homePage.dart';
import 'package:client/widget/itemCard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
class DisplaySuggestionsPage extends StatefulWidget {

  final File image;
  DisplaySuggestionsPage({@required this.image});

  @override
  _DisplaySuggestionsPageState createState() => _DisplaySuggestionsPageState();
}

class _DisplaySuggestionsPageState extends State<DisplaySuggestionsPage> {

  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  Future suggestions;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    suggestions = SuggestionsService().uploadPicture(context, image: widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: titleAppbar(context, title: 'Choose from suggestions'),
      body: FutureBuilder(
        future: suggestions,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return _loading == false ? ListView.builder(
              itemCount: snapshot.data['tags'].length,
              itemBuilder: (context, index) {
                return ItemCard(
                  title: snapshot.data['tags'][index], 
                  onPressed: () async {
                    setState(() {
                      _loading = !_loading;
                    });
                    setState(() {
                      _loading = !_loading;
                    });
                    
                    Response response = await SuggestionsService().saveSuggestion(context, snapshot, index);

                    if(response.statusCode == 200){
                      int i=0;
                      Navigator.popUntil(_scaffoldKey.currentContext, (route) => i++==1);
                    }
                  }, 
                  trailing: Icons.arrow_forward, 
                  imageUrl: snapshot.data['url']
                );
              },
            ) : Center(
              child: LoadingFlipping.square(),
            );
          }
          else{
            return Center(
              child: LoadingFlipping.square(),
            );
          }
        },
      ),
    );
  }
}