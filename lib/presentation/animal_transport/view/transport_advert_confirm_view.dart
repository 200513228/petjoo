import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/presentation/animal_transport/view_model/transport_advert_confirm_view_model.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class TransportAdvertConfirmView extends ConsumerStatefulWidget {
  final GeoPoint beginPoint;
  final GeoPoint endPoint;
  final double pricePerKm;
  final double markerSize;
  const TransportAdvertConfirmView(this.beginPoint, this.endPoint, this.pricePerKm, this.markerSize, {Key? key}) : super(key: key);

  @override
  ConsumerStateX<TransportAdvertConfirmView> createState() => _TransportAdvertConfirmViewState();
}

class _TransportAdvertConfirmViewState extends ConsumerStateX<TransportAdvertConfirmView> {
  late final transportAdvertConfirmViewModel =
      ChangeNotifierProvider.autoDispose((ref) => TransportAdvertConfirmViewModel(context, widget.beginPoint, widget.endPoint, widget.pricePerKm, widget.markerSize));
  late final viewModel = ref.read(transportAdvertConfirmViewModel);

  @override
  void initState() {
    viewModel.getMarkers();
    viewModel.calculateDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Dimens.radius.toBorderRadius(),
          color: theme.colorScheme.surface,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: Dimens.radius.toTopBorderRadius(),
                child: SizedBox(
                  height: 160,
                  child: Consumer(builder: (context, ref, _) {
                    ref.watch(transportAdvertConfirmViewModel.select((value) => value.markers.length));
                    return GoogleMap(
                      initialCameraPosition: viewModel.cameraPosition,
                      mapType: MapType.normal,
                      mapToolbarEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: false,
                      scrollGesturesEnabled: true,
                      markers: viewModel.markers,
                      polylines: viewModel.polylines,
                      onMapCreated: viewModel.onMapCreated,
                    );
                  }),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                localization.averageDistance,
                style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onSurface),
                textAlign: TextAlign.left,
              ),
              Text(
                "${viewModel.distance.round()}${localization.km}",
                style: const TextStyle(fontSize: 19),
                textAlign: TextAlign.left,
              ),
              Text(
                localization.estimatedAmount,
                style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onSurface),
                textAlign: TextAlign.left,
              ),
              Text(
                "${localization.turkishCurrency}${(viewModel.distance * viewModel.pricePerKm).toStringAsFixed(2)}",
                style: TextStyle(color: theme.colorScheme.primary, fontSize: 26),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: ButtonX(
                      color: theme.colorScheme.onBackground,
                      borderRadius: Dimens.paddingSmall.toBorderRadius(),
                      onTap: () => viewModel.pop(false),
                      child: Text(localization.cancel),
                    ),
                  ),
                  const Separator(),
                  Expanded(
                    child: ButtonX(
                      color: theme.colorScheme.primary,
                      borderRadius: Dimens.paddingSmall.toBorderRadius(),
                      onTap: () => viewModel.pop(true),
                      child: Text(
                        localization.approve,
                        style: TextStyle(color: theme.colorScheme.onBackground),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
