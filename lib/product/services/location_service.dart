import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static Future<void> determineLocation(
      {Function()? onServiceDisabled,
      Function()? onPermissionDenied,
      Function()? onPermissionDeniedForever,
      Function(LatLng)? onLocationDetermined}) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log("Denied", name: "Location");
        onPermissionDenied?.call();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log("DeniedForever", name: "Location");
      onPermissionDeniedForever?.call();
      return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition();
      onLocationDetermined?.call(LatLng(pos.latitude, pos.longitude));
    } catch (_) {
      onServiceDisabled?.call();
    }
  }

  Future<LatLng> getLastKnownPosition() async {
    final pos = await Geolocator.getLastKnownPosition();
    if (pos == null) return const LatLng(0, 0);
    return LatLng(pos.latitude, pos.longitude);
  }
}
