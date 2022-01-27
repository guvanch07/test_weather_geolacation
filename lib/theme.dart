import 'package:flutter/material.dart';
import 'package:test_simple_weather_app/core/const/colors/colors.dart';

final ThemeData theme = ThemeData(
  textTheme: const TextTheme(
    headline1: TextStyle(
        color: kTempTextColor,
        fontSize: 33,
        fontWeight: FontWeight.w600,
        fontFamily: '.SF UI Display'),
    headline2: TextStyle(
        color: kTextColo,
        fontSize: 20,
        fontWeight: FontWeight.normal,
        fontFamily: '.SF UI Display'),
    bodyText1: TextStyle(
        color: kTempTextColor,
        fontSize: 20,
        fontWeight: FontWeight.normal,
        fontFamily: '.SF UI Display'),
    bodyText2: TextStyle(
        color: kTextColo,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: '.SF UI Display'),
  ),
);
