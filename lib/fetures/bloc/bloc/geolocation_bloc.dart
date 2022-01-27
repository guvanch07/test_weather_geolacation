import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:test_simple_weather_app/fetures/data/datasource/base.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeoRepo _geoRepo;
  StreamSubscription? _streamSubscription;
  GeolocationBloc({
    required GeoRepo geoRepo,
  })  : _geoRepo = geoRepo,
        super(GeolocationLoading());
  @override
  Stream<GeolocationState> mapEventToState(
    GeolocationEvent event,
  ) async* {
    if (event is LoadGeolocation) {
      yield* mapLoadToState();
    } else if (event is UpdateGeolocation) {
      yield* mapUpdateToState(event);
    } else if (event is UpdateGeolocationCity) {
      yield* maptoLocation();
    }
  }

  Stream<GeolocationState> mapLoadToState() async* {
    _streamSubscription?.cancel();
    final Position position = await _geoRepo.getCurrentLocation();

    add(UpdateGeolocation(position: position));
  }

  Stream<GeolocationState> maptoLocation() async* {
    final Position position = await _geoRepo.getCurrentLocation();
    List<Placemark> pm =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = pm[0];
    add(UpdateGeolocationCity(city: place.locality.toString()));
  }

  Stream<GeolocationState> mapUpdateToStateCity(
      UpdateGeolocationCity event) async* {
    yield GeolocationLoadedCity(city: event.city);
  }

  Stream<GeolocationState> mapUpdateToState(UpdateGeolocation event) async* {
    yield GeolocationLoaded(position: event.position);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
