
import 'dart:io';
import 'package:flutter/material.dart';

String _imagePath = "";
class CameraWipe extends StatelessWidget {
  const CameraWipe({Key? key}) : super(key: key);

  set imagePath(String path) {
    _imagePath = path;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: _imagePath!="" ? 1.0 : 0.0,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(5.0),
          child: Image.file(File(_imagePath)),
        )
    );
  }
}