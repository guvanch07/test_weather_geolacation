import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:test_simple_weather_app/core/const/api_key.dart';
import 'package:test_simple_weather_app/core/const/error/exseption.dart';

import 'package:test_simple_weather_app/fetures/data/models/forcast.dart';
import 'package:test_simple_weather_app/fetures/data/models/weather.dart';
import 'package:test_simple_weather_app/fetures/presentation/pages/home_page.dart';

abstract class DataSourceRepo {
  Future<Weather> getCurrentWeather();
  Future<Forecast> getForecast();
  //Future<List<String>> locationPoint();
}

class WeatherDataSourceImpl implements DataSourceRepo {
  @override
  Future<Forecast> getForecast() async {
    //LocationWB? location;
    try {
      // String lat = location.lat;
      // String lon = location.lon;
      var url =
          "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

      final response = await http.get(Uri.parse(url));

      final forecast = Forecast.fromJson(jsonDecode(response.body));

      return forecast;
    } catch (e) {
      throw ServerException(message: 'get Exception');
    }
  }

  @override
  Future<Weather> getCurrentWeather() async {
    try {
      //String city = location.city;
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
