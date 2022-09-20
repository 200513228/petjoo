import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/location/viewmodel/location_pick_viewmodel.dart';

class LocationPickView extends StatelessWidget {
  final LocationPickViewModel vm = LocationPickViewModel();
  final Position position;
  LocationPickView({required this.position, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    vm.setCurrentLoc(position);
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Observer(builder: (_) {
                return GoogleMap(
                  zoomControlsEnabled: true,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: vm.camPos!,
                  onCameraMove: (position) {
                    vm.onCameraMove(position);
                  },
                );
              }),
              const Center(
                child: Icon(
                  Icons.location_on_sharp,
                  color: Colors.red,
                  size: 48,
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                    onPressed: () => vm.onSave(context),
                    child: Text('save'.tr())),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
