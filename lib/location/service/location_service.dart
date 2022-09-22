import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class LocationService {
  static const String _directionsUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  static final Dio _dio = Dio();

  static Future<double> getDirections({
    required GeoPoint origin,
    required GeoPoint destination,
  }) async {
    final response = await _dio.get(
      _directionsUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyDqyG86qwkp69apvVnp0h52FXFNz8PUZ1w',
        'units': 'metric'
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      var result = response.data['routes'][0]['legs'][0]['distance']['text'];
      return double.parse(result.toString().split(' ')[0]);
    } else {
      return 0.0;
    }
  }
}
