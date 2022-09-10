import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
part 'location_pick_viewmodel.g.dart';

class LocationPickViewModel = LocationPickViewModelBase
    with _$LocationPickViewModel;

abstract class LocationPickViewModelBase with Store {
  @observable
  GeoPoint loc = const GeoPoint(0, 0);
  @observable
  CameraPosition camPos = const CameraPosition(target: LatLng(0, 0), zoom: 13);
  @action
  onCameraMove(xcamPos) {
    camPos = xcamPos;
    loc = GeoPoint(camPos.target.latitude, camPos.target.longitude);
  }

  @action
  onSave(BuildContext context) {}
}
