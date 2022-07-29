import 'dart:developer';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/lat_lng_extension.dart';
import 'package:petjoo/product/constants/map_argument.dart';
import 'package:petjoo/product/services/location_service.dart';

class TransportAdvertMapViewModel extends PageNotifier {
  TransportAdvertMapViewModel(super.context, this.geoPoint);
  GeoPoint? geoPoint;

  late GoogleMapController _mapController;
  CancelableOperation? cancelableOperation;

  late LatLng currentLocation = geoPoint != null ? LatLng(geoPoint!.latitude, geoPoint!.longitude) : const LatLng(34, 34);

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.setMapStyle(MapArgument.darkStyleText);
    if (geoPoint == null) {
      cancelableOperation = CancelableOperation.fromFuture(
        LocationService.determineLocation(
            onPermissionDenied: context.pop,
            onPermissionDeniedForever: context.pop,
            onServiceDisabled: context.pop,
            onLocationDetermined: (pos) => _mapController.animateCamera(CameraUpdate.newLatLng(pos))),
        onCancel: () => log("Location Request Cancelled", name: "Future"),
      );
    }
  }

  void onCameraMove(CameraPosition position) => currentLocation = position.target;

  void save() {
    geoPoint = currentLocation.toGeoPoint();
    context.pop(result: geoPoint);
  }
}
