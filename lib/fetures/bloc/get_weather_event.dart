part of 'get_weather_bloc.dart';

abstract class GetWeatherEvent extends Equatable {
  const GetWeatherEvent();
}

class GetApiWeather extends GetWeatherEvent {
  @override
  List<Object> get props => [];
}
