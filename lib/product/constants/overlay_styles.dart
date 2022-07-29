import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OverlayStyles {
  static SystemUiOverlayStyle toAll(Color color, Brightness brightness) => SystemUiOverlayStyle(
      statusBarColor: color, systemNavigationBarColor: color, statusBarIconBrightness: brightness, systemNavigationBarIconBrightness: brightness);
  
  static SystemUiOverlayStyle toNavigationBar(Color color, Brightness brightness) => SystemUiOverlayStyle(
      systemNavigationBarColor: color, systemNavigationBarIconBrightness: brightness);
}
