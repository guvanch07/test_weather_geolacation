import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:test_simple_weather_app/core/geolocator.dart';

import 'package:test_simple_weather_app/fetures/data/models/location.dart';

import 'package:test_simple_weather_app/fetures/presentation/pages/first_page.dart';
import 'package:test_simple_weather_app/fetures/presentation/pages/second_page.dart';

String lat = "23.44";
String lon = "27.34";
String city = "minsk";
String country = "";

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    //required this.location,
  }) : super(key: key);
  //final LocationWB location;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  final LocationWB location =
      LocationWB(city: city, country: country, lat: lat, lon: lon);

  Future locationPoint() async {
    Position pos = await determinePosition();
    List<Placemark> pm =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    Placemark place = pm[0];
    setState(() {
      lat = pos.latitude.toString();
      lon = pos.longitude.toString();
      city = place.locality.toString();
      country = place.country.toString();

      log(city);
      log(lat);
      log(lon);
      log(country);
    });
  }

  @override
  void initState() {
    locationPoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.blueAccent,
        inactiveColor: const Color(0xFF9FABBF),
        onTap: changeTabIndex,
        currentIndex: tabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny_outlined),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_shade),
            label: 'Forecast',
          )
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => const FirstPage(),
            );

          case 1:
            return CupertinoTabView(
              builder: (context) => const SecondScreen(),
            );

          default:
            return Container(
              color: Colors.amber,
            );
        }
      },
    );
  }
}



// class GetLocationWithCubit extends Cubit<String> {
//   GetLocationWithCubit(String initialState) : super(initialState);

//   Future locationPoint() async {
//     Position pos = await determinePosition();
//     List<Placemark> pm =
//         await placemarkFromCoordinates(pos.latitude, pos.longitude);
//     Placemark place = pm[0];

//     emit(lat = pos.latitude.toString());
//     emit(lon = pos.longitude.toString());
//     emit(city = place.locality.toString());
//     emit(country = place.country.toString());

//     log(city);
//     log(lat);
//     log(lon);
//     log(country);
//   }
// }
