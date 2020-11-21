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
                    var token = context.read<TokenService>().getToken;
                    Response response = await Dio().post(
                      '$api/api/v1/image/selectTags',
                      options: Options(
                        headers: {
                          "x-auth-token": token,
                        }
                      ),
                      data: {
                        'url': snapshot.data['url'],
                        'tag': snapshot.data['tags'][index],
                      }
                    );
                    setState(() {
                      _loading = !_loading;
                    });
                    if(response.statusCode == 200){
                      int i=0;
                      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => new HomePage()));
                      //Navigator.pop(context);
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