import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Map<String, double>> getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return {
      "latitude": position.latitude,
      "longitude": position.longitude,
    };
  }
}
