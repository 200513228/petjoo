import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:petjoo/location/view/location_pick_view.dart';
import 'package:petjoo/ui/color_palette.dart';

Future<GeoPoint?> showLocationPicker(BuildContext context) async {
  await Geolocator.requestPermission();
  // pos = await Geolocator.getCurrentPosition();
  // return await showDialog<GeoPoint?>(
  //     barrierDismissible: false,
  //     barrierColor: colorPalette['primary'],
  //     context: context,
  //     builder: (context) => LocationPickView(position: pos!));
  return await Geolocator.getCurrentPosition().then((value) async =>
      await showDialog<GeoPoint?>(
          barrierDismissible: false,
          barrierColor: colorPalette['primary'],
          context: context,
          builder: (context) => LocationPickView(position: value)));
}
