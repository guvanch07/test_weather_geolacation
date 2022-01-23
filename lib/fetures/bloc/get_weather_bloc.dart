import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_simple_weather_app/fetures/data/datasource/remote_datasource.dart';
import 'package:test_simple_weather_app/fetures/data/models/forcast.dart';
import 'package:test_simple_weather_app/fetures/data/models/location.dart';
import 'package:test_simple_weather_app/fetures/data/models/weather.dart';

part 'get_weather_event.dart';
part 'get_weather_state.dart';

class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  final WeatherDataSourceImpl dataSourceImpl;
  final LocationWB location;

  GetWeatherBloc(
    this.dataSourceImpl,
    this.location,
  ) : super(GetWeatherLoading()) {
    on<GetApiWeather>((event, emit) async {
      emit(GetWeatherLoading());
      final getforcast = await dataSourceImpl.getForecast(location);
      final getcurrent = await dataSourceImpl.getCurrentWeather(location);

      // final getlocation = await dataSourceImpl.locationPoint();
      emit(GetWeatherLoaded(
        //location: getlocation,
        current: getcurrent,
        forecast: getforcast,
      ));
    });
  }
}
