import 'dart:convert';
import 'dart:io';
import 'package:client/auth/login/tokenService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SuggestionsService{
  Future uploadPicture(BuildContext context, {@required File image}) async {

    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path,
        filename: image.path,
      )
    });

    var token = context.read<TokenService>().getToken;
    print('Token: $token');

    Response response = await Dio().post(
      '$api/api/v1/image',
      options: Options(
        headers: {
          'x-auth-token': token,
        }
      ),
      data: formData,
    );

    if (response.statusCode == 200) {
      var data = response.data;
      print(data);
      return data;
    }
    else{
      return null;
    }

  }
}