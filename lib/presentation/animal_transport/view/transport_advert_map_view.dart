import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/presentation/animal_transport/view_model/transport_advert_map_view_model.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';

class TransportAdvertMapView extends ConsumerStatefulWidget {
  final GeoPoint? geoPoint;
  const TransportAdvertMapView({this.geoPoint, Key? key}) : super(key: key);

  @override
  ConsumerStateX<TransportAdvertMapView> createState() => _TransportAdvertMapViewState();
}

class _TransportAdvertMapViewState extends ConsumerStateX<TransportAdvertMapView> {
  late final transportAdvertMapViewModel = ChangeNotifierProvider.autoDispose((ref) => TransportAdvertMapViewModel(context, widget.geoPoint));
  late final viewModel = ref.read(transportAdvertMapViewModel);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toNavigationBar(theme.colorScheme.surface, Brightness.light),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(localization.pickLocation),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              label: Text(localization.pickLocation),
              onPressed: viewModel.save,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Material(
                    color: theme.colorScheme.surface,
                    clipBehavior: Clip.antiAlias,
                    borderRadius: Dimens.radius.toTopBorderRadius(),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: Dimens.radius.toBorderRadius(),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(target: viewModel.currentLocation, zoom: 12),
                            minMaxZoomPreference: const MinMaxZoomPreference(8, 17),
                            mapToolbarEnabled: false,
                            myLocationButtonEnabled: false,
                            zoomControlsEnabled: false,
                            onMapCreated: viewModel.onMapCreated,
                            onCameraMove: viewModel.onCameraMove,
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  Images.customMarker,
                                  height: 60,
                                  width: 60,
                                ),
                                const SizedBox(height: 90),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
