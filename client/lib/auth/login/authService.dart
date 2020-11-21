import 'dart:convert';

import 'package:client/constants.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
  );

  Future signIn() async {

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');
      Response response = await Dio().post(
        '$api/api/v1/auth',
        data: {
          "email": "${user.email}"
        }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(jsonEncode(response.data).toString());
        var token = data['token'];
        SharedPreferences _sharedPref = await SharedPreferences.getInstance();
        await _sharedPref.setString('token', '$token');
        return '$user';
      }
      else{
        return null;
      }
    }

    return null;
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    print(await _sharedPref.get('token'));
    await _sharedPref.clear();
    print("User Signed Out");
  }

}