import 'package:camera/camera.dart';
import 'package:client/auth/login/login_ui.dart';
import 'package:client/auth/login/tokenService.dart';
import 'package:client/blankPage.dart';
import 'package:client/camera/cameraService.dart';
import 'package:client/home/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CameraService()),
      ChangeNotifierProvider(create: (_) => TokenService()),
    ],
    child: MyApp()
  ));
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getToken() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    String token = _sharedPreferences.getString('token');
    print(token);
    if(token == null){
      return '';
    }
    else{
      return token;
    }
  }

  Future<CameraDescription> initializeCamera() async {
    final cameras = await availableCameras();

    return cameras.first;
  }

  Future token;
  Future<CameraDescription> camera;

  @override
  void initState(){
    super.initState();
    token = getToken();
    camera = initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: camera,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            context.watch<CameraService>().addCamera(snapshot.data);
            return FutureBuilder(
          future: token,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              context.watch<TokenService>().addToken(token: snapshot.data);
              if(snapshot.data != ''){
                print('Home Page');
                return HomePage();
              }
              else{
                print('Login Page');
                return LoginPage();
              }
            }
            else{
              return BlankPage();
            }
          },
        );
          }
          else{
            return BlankPage();
          }
        },
      ),
    );
  }
}