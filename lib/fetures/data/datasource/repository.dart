import 'package:test_simple_weather_app/fetures/data/models/forcast.dart';
import 'package:test_simple_weather_app/fetures/data/models/weather.dart';

abstract class DataSourceRepo {
  Future<Weather> getCurrentWeather();
  Future<Forecast> getForecast();
}
