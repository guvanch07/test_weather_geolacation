import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    }
  }

  Stream<GeolocationState> mapLoadToState() async* {
    _streamSubscription?.cancel();
    final Position position = await _geoRepo.getCurrentLocation();

    add(UpdateGeolocation(position: position));
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
