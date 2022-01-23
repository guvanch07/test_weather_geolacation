part of 'get_weather_bloc.dart';

abstract class GetWeatherState extends Equatable {
  const GetWeatherState();

  @override
  List<Object> get props => [];
}

class GetWeatherLoading extends GetWeatherState {}

class GetWeatherError extends GetWeatherState {
  final String error;
  const GetWeatherError({
    required this.error,
  });
}

class GetWeatherLoaded extends GetWeatherState {
  final Weather current;
  final Forecast forecast;
  //final LocationWB location;
  // final String lat;
  // final String lon;
  // final String city;
  // final String country;
  const GetWeatherLoaded({
    required this.current,
    required this.forecast,
    //required this.location,
  });
  @override
  List<Object> get props => [current, forecast];
}
