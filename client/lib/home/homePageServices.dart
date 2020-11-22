import 'package:client/auth/login/tokenService.dart';
import 'package:client/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomeServices{

  
  Future getList(BuildContext context) async {

    var token = context.read<TokenService>().getToken;

    print('Token: $token');

    Response response = await Dio().get(
      '$api/api/v1/grocery/get',
      options: Options(
        headers: {
          'x-auth-token': token,
        }
      )
    );

    try{
      if(response.statusCode == 200){
        print(response.data);
        return response.data;
      }
    }
    catch(e){
      return null;
    }

  }
  

}