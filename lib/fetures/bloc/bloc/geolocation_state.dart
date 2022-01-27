part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationLoading extends GeolocationState {}

class GeolocationError extends GeolocationState {}

class GeolocationLoaded extends GeolocationState {
  final Position position;

  const GeolocationLoaded({
    required this.position,
  });
}

class GeolocationLoadedCity extends GeolocationState {
  final String city;
  const GeolocationLoadedCity({
    required this.city,
  });
}
