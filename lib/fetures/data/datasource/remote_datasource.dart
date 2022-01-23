import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:test_simple_weather_app/core/const/api_key.dart';
import 'package:test_simple_weather_app/core/const/error/exseption.dart';
import 'package:test_simple_weather_app/core/geolocator.dart';
import 'package:test_simple_weather_app/fetures/data/models/forcast.dart';
import 'package:test_simple_weather_app/fetures/data/models/location.dart';
import 'package:test_simple_weather_app/fetures/data/models/weather.dart';

abstract class DataSourceRepo {
  Future<Weather> getCurrentWeather(LocationWB location);
  Future getForecast(LocationWB location);
  //Future<LocationWB> locationPoint();
}

class WeatherDataSourceImpl implements DataSourceRepo {
  // @override
  // Future<LocationWB> locationPoint() async {
  //   Position pos = await determinePosition();
  //   List<Placemark> pm =
  //       await placemarkFromCoordinates(pos.latitude, pos.longitude);
  //   Placemark place = pm[0];
  //   final LocationWB location = LocationWB(
  //       city: place.locality.toString(),
  //       country: place.country.toString(),
  //       lat: pos.latitude.toString(),
  //       lon: pos.longitude.toString());
  //   return location;
  // }
  @override
  Future getForecast(LocationWB location) async {
    Weather? weather;
    String city = location.city;
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    }

    return weather;
    // try {
    //   String lat = location.lat;
    //   String lon = location.lon;
    //   var url =
    //       "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    //   final response = await http.get(Uri.parse(url));

    //   final forecast = Forecast.fromJson(jsonDecode(response.body));

    //   return forecast;
    // } catch (e) {
    //   throw ServerException(message: 'get Exception');

    // }
  }

  @override
  Future<Weather> getCurrentWeather(LocationWB location) async {
    try {
      String city = location.city;
      var url =
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

      final response = await http.get(Uri.parse(url));

      final weather = Weather.fromJson(jsonDecode(response.body));

      return weather;
    } catch (e) {
      throw ServerException(message: 'get Exception');
    }
  }
}
