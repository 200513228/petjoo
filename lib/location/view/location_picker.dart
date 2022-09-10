import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/location/view/location_pick_view.dart';
import 'package:petjoo/ui/color_palette.dart';

Future<GeoPoint?> showLocationPicker(BuildContext context) async {
  return await showDialog<GeoPoint?>(
      barrierDismissible: false,
      barrierColor: colorPalette['primary'],
      context: context,
      builder: (context) => LocationPickView());
}
