import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_simple_weather_app/core/geolocator.dart';
import 'package:test_simple_weather_app/fetures/bloc/get_weather_bloc.dart';
import 'package:test_simple_weather_app/fetures/bloc/location.dart';
import 'package:test_simple_weather_app/fetures/data/datasource/remote_datasource.dart';
import 'package:test_simple_weather_app/fetures/data/models/location.dart';
import 'package:test_simple_weather_app/fetures/presentation/pages/first_page.dart';
import 'package:test_simple_weather_app/fetures/presentation/pages/second_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

  @override
  void initState() {
    //determinePosition();
    //BlocProvider.of<LocationPoint>(context).locationPoint();
    context.read<LocationPoint>().locationPoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LocationPoint>();
    final LocationWB location = LocationWB(
        city: provider.city,
        country: provider.country,
        lat: provider.lat,
        lon: provider.lon);
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
              builder: (context) => FirstPage(
                location: location,
              ),
            );

          case 1:
            return CupertinoTabView(
              builder: (context) => SecondScreen(
                location: location,
              ),
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
