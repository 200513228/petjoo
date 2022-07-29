import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LatLngExtension on LatLng{
  GeoPoint toGeoPoint() => GeoPoint(latitude, longitude);
}