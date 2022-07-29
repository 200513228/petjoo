import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/infrastructure/repositories/advert_repository_impl.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';

import '../view_model/advert_map_input_view_model.dart';

class AdvertMapInputView extends ConsumerStatefulWidget {
  final AdvertModel data;
  const AdvertMapInputView(this.data, {Key? key}) : super(key: key);

  @override
  ConsumerStateX<AdvertMapInputView> createState() => _AdvertMapInputViewState();
}

class _AdvertMapInputViewState extends ConsumerStateX<AdvertMapInputView> {
  late final advertMapInputViewModel = ChangeNotifierProvider.autoDispose((ref) => AdvertMapInputViewModel(context, AdvertRepositoryImpl(), widget.data));
  late final viewModel = ref.read(advertMapInputViewModel);

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(advertMapInputViewModel.select((value) => value.isLoading));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toNavigationBar(theme.colorScheme.surface, Brightness.light),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(localization.locationOfAdvert),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(primary: theme.colorScheme.secondary),
                  onPressed: viewModel.skip,
                  child: Text(localization.skip),
                )
              ],
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
                            minMaxZoomPreference: const MinMaxZoomPreference(12, 16),
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
                          isLoading ? Loading(background: theme.colorScheme.surface) : const SizedBox()
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
