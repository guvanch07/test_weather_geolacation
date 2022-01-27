part of 'geolocation_bloc.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  List<Object> get props => [];
}

class LoadGeolocation extends GeolocationEvent {}

class UpdateGeolocation extends GeolocationEvent {
  final Position position;
  const UpdateGeolocation({
    required this.position,
  });
  @override
  List<Object> get props => [position];
}

class UpdateGeolocationCity extends GeolocationEvent {
  final String city;
  const UpdateGeolocationCity({
    required this.city,
  });
  @override
  List<Object> get props => [city];
}
