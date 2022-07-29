import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/map_argument.dart';

class TransportAdvertConfirmViewModel extends PageNotifier {
  TransportAdvertConfirmViewModel(super.context, this.beginPoint, this.endPoint, this.pricePerKm, this.markerSize);

  GeoPoint beginPoint;
  GeoPoint endPoint;
  double pricePerKm;
  double markerSize;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  late double distance;
  late GoogleMapController mapController;

  void pop(bool result) => context.pop(result: result);

  CameraPosition get cameraPosition => CameraPosition(target: LatLng((beginPoint.latitude + endPoint.latitude) / 2, (beginPoint.longitude + endPoint.longitude) / 2), zoom: 8);

  Future<void> getMarkers() async {
    final Uint8List markerIcon = await MapArgument.getBytesFromAsset(Images.customMarker, markerSize.floor());
    LatLng beginLocation = LatLng(beginPoint.latitude, beginPoint.longitude);
    markers.add(Marker(
      markerId: MarkerId(beginLocation.toString()),
      position: beginLocation,
      icon: BitmapDescriptor.fromBytes(markerIcon),
    ));
    LatLng endLocation = LatLng(endPoint.latitude, endPoint.longitude);
    markers.add(Marker(
      markerId: MarkerId(endLocation.toString()),
      position: endLocation,
      icon: BitmapDescriptor.fromBytes(markerIcon),
    ));

    final PolylineId polylineId = PolylineId(beginLocation.toString());
    polylines.add(Polyline(polylineId: polylineId, points: [beginLocation, endLocation], startCap: Cap.roundCap, endCap: Cap.roundCap, color: Colors.yellow, width: 3));

    notifyListeners();
  }

  void calculateDistance() => distance = MapArgument.calculateDistance(beginPoint, endPoint);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(MapArgument.darkStyleText);

    LatLng latLng_1 = LatLng(beginPoint.latitude, beginPoint.longitude);
    LatLng latLng_2 = LatLng(endPoint.latitude, endPoint.longitude);
    LatLngBounds bound = LatLngBounds(southwest: latLng_2, northeast: latLng_1);

    notifyListeners();
    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
    mapController.animateCamera(u2);
  }
}
