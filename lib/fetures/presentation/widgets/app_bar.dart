import 'package:flutter/material.dart';
import 'package:test_simple_weather_app/core/const/colors/colors.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    Key? key,
    context,
    required String title,
  }) : super(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: kBackgroundColor,
          key: key,
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline2,
          ),
        );
}
