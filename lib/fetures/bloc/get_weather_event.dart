part of 'get_weather_bloc.dart';

abstract class GetWeatherEvent extends Equatable {
  const GetWeatherEvent();
}

class GetApiWeather extends GetWeatherEvent {
  @override
  List<Object> get props => [];
}

class GetApiCityLocation extends GetWeatherEvent {
  final String location;
  const GetApiCityLocation({
    required this.location,
  });
  @override
  List<Object> get props => [];
}
