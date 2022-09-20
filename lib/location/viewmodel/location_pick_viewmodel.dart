import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
part 'location_pick_viewmodel.g.dart';

class LocationPickViewModel = LocationPickViewModelBase
    with _$LocationPickViewModel;

abstract class LocationPickViewModelBase with Store {
  @observable
  GeoPoint loc = const GeoPoint(41.046888, 28.845604);
  @observable
  CameraPosition? camPos;
  @observable
  Position? currentPos;

  @action
  void setCurrentLoc(Position xpos) {
    // await Geolocator.requestPermission();
    // var pos = await Geolocator.getCurrentPosition();
    currentPos = xpos;
    camPos = CameraPosition(
        target: LatLng(currentPos!.latitude, currentPos!.longitude), zoom: 16);
    loc = GeoPoint(camPos!.target.latitude, camPos!.target.longitude);
  }

  @action
  void onCameraMove(xcamPos) {
    camPos = xcamPos;
    loc = GeoPoint(camPos!.target.latitude, camPos!.target.longitude);
  }

  @action
  void onSave(BuildContext context) {
    Navigator.pop(context, loc);
  }
}
