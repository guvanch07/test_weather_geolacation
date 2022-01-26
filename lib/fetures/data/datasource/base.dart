import 'package:geolocator/geolocator.dart';

abstract class BaseGeolocatorRepo {
  Future<Position> getCurrentLocation();
}

class GeoRepo extends BaseGeolocatorRepo {
  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
