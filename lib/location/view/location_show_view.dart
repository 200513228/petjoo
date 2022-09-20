import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationShowView extends StatelessWidget {
  final GeoPoint point;
  const LocationShowView({required this.point, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            markers: {
              Marker(
                  markerId: const MarkerId('target'),
                  position: LatLng(point.latitude, point.longitude)),
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(point.latitude, point.longitude),
              zoom: 18,
            ),
          ),
        ),
        Row(
          children: [
            FloatingActionButton(
              onPressed: () => Navigator.pop(context),
              heroTag: null,
              child: const Icon(Icons.arrow_back_ios_new_sharp),
            ),
            Expanded(
              child: FloatingActionButton.extended(
                onPressed: () {},
                label: Text('directions'.tr()),
              ),
            ),
            FloatingActionButton(
              onPressed: () {},
              heroTag: null,
            ),
          ],
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
