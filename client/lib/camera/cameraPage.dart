import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
class CameraPage extends StatefulWidget {

  final CameraDescription cameraDescription;
  CameraPage({
    @required this.cameraDescription,
  });

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  CameraController _cameraController;
  

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}