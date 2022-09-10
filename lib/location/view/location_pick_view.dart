import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/location/viewmodel/location_pick_viewmodel.dart';

class LocationPickView extends StatelessWidget {
  final LocationPickViewModel vm = LocationPickViewModel();
  LocationPickView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    vm.onCameraMove(
        CameraPosition(target: LatLng(vm.loc.latitude, vm.loc.longitude)));
    return Column(
      children: [
        Expanded(
          child: Observer(builder: (_) {
            return GoogleMap(
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: vm.camPos,
              onCameraMove: (position) {
                vm.onCameraMove(position);
              },
            );
          }),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, vm.loc);
                    },
                    child: Text('save'.tr())),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
