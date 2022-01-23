import 'package:flutter/material.dart';

Image getWeatherIcon(
    {required String icon, required double width, required double height}) {
  String path = 'assets/icons/';
  String imageExtension = ".png";
  return Image.asset(
    path + icon + imageExtension,
    width: width,
    height: height,
  );
}
