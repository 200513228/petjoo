import 'dart:developer';

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
  CameraPosition camPos =
      const CameraPosition(target: LatLng(38, 38), zoom: 16);

  @action
  Future currentLoc() async {
    await Geolocator.requestPermission();
    var pos = await Geolocator.getCurrentPosition();
    log(pos.toString());
    camPos =
        CameraPosition(target: LatLng(pos.latitude, pos.longitude), zoom: 16);
    loc = GeoPoint(camPos.target.latitude, camPos.target.longitude);
  }

  @action
  void onCameraMove(xcamPos) {
    camPos = xcamPos;
    loc = GeoPoint(camPos.target.latitude, camPos.target.longitude);
  }

  @action
  void onSave(BuildContext context) {
    Navigator.pop(context, loc);
  }
}
