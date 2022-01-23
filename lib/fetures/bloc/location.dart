import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_simple_weather_app/core/geolocator.dart';

// class LocationPoint extends Cubit<String> {
//   String lat = "";
//   String lon = "";
//   String city = "";
//   String country = "";

//   LocationPoint() : super('Minsk');

//   Future locationPoint() async {
//     Position pos = await determinePosition();
//     List<Placemark> pm =
//         await placemarkFromCoordinates(pos.latitude, pos.longitude);
//     Placemark place = pm[0];
//     emit(lat = pos.latitude.toString());
//     emit(lon = pos.longitude.toString());
//     emit(city = place.locality.toString());
//     emit(country = place.country.toString());
//   }
// }

class LocationPoint extends ChangeNotifier {
  String lat = "";
  String lon = "";
  String city = "";
  String country = "";

  Future locationPoint() async {
    Position pos = await determinePosition();
    List<Placemark> pm =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    Placemark place = pm[0];
    lat = pos.latitude.toString();
    lon = pos.longitude.toString();
    city = place.locality.toString();
    country = place.country.toString();

    notifyListeners();
  }
}
