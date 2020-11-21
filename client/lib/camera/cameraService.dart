import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CameraService with ChangeNotifier, DiagnosticableTreeMixin{

  CameraDescription _cameraDescription;

  CameraDescription get camera => _cameraDescription;

  void addCamera(CameraDescription cameraDescription){
    _cameraDescription = cameraDescription;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('cameraDescription', 1));
  }

}