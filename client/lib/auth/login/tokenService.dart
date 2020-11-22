import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class TokenService with ChangeNotifier , DiagnosticableTreeMixin{

  String token;

  String get getToken => token;

  void addToken({@required String token}){
    this.token = token;
  }

  void removeToken(){
    this.token = null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('tokenService', 1));
  }

}