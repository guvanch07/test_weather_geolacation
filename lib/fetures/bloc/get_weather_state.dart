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

  const GetWeatherLoaded({
    required this.current,
    required this.forecast,
  });
  @override
  List<Object> get props => [current, forecast];
}

class GetWeatherLocation extends GetWeatherState {
  final String location;
  const GetWeatherLocation({
    required this.location,
  });
}
