import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/datetime_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/infrastructure/model/transport_reservation_model.dart';
import 'package:petjoo/infrastructure/repositories/transport_repository_impl.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/ui/widgets/image_x.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';
import '../../../product/ui/tiles/rezervation_schedule_tile.dart';
import '../view_model/transport_reservation_detail_view_model.dart';

class TransportReservationDetailView extends ConsumerStatefulWidget {
  const TransportReservationDetailView(this.data, {Key? key}) : super(key: key);

  final TransportReservationModel data;

  @override
  ConsumerStateX<TransportReservationDetailView> createState() =>
      _TransportReservationDetailViewState();
}

class _TransportReservationDetailViewState
    extends ConsumerStateX<TransportReservationDetailView> {
  late final reservationDetailViewModel = ChangeNotifierProvider((ref) =>
      TransportReservationDetailViewModel(context, TransportRepositoryImpl(),
          ref.read(chatProvider), widget.data));

  late final viewModel = ref.read(reservationDetailViewModel);

  TransportAdvertModel get advert => viewModel.advert!;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(reservationDetailViewModel.select((value) => value.isLoading));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toNavigationBar(
          theme.colorScheme.surface, Brightness.light),
      child: isLoading
          ? Loading(
              background: theme.colorScheme.background,
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(localization.reservationDetail),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Material(
                      color: theme.colorScheme.surface,
                      clipBehavior: Clip.antiAlias,
                      borderRadius: Dimens.radius.toTopBorderRadius(),
                      child: CustomScrollView(slivers: [
                        SliverAppBar(
                          expandedHeight: mediaQuery.size.width * .75,
                          automaticallyImplyLeading: false,
                          bottom: PreferredSize(
                              preferredSize:
                                  const Size.fromHeight(Dimens.padding),
                              child: Container(
                                  height: Dimens.padding,
                                  decoration: BoxDecoration(
                                      color: theme.colorScheme.surface,
                                      borderRadius:
                                          Dimens.radius.toTopBorderRadius()))),
                          flexibleSpace: advert.images.isEmpty
                              ? Image.asset(
                                  Images.noImage,
                                  fit: BoxFit.cover,
                                )
                              : PageView.builder(
                                  itemCount: advert.images.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        child: ImageX(
                                          advert.images[index],
                                        ),
                                        onTap: () =>
                                            viewModel.showFullScreen(index),
                                      )),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(Dimens.padding, 0,
                              Dimens.padding, Dimens.padding),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Text(
                                  advert.title,
                                  style: theme.textTheme.headline6?.copyWith(
                                      color: theme.colorScheme.onSurface),
                                  maxLines: 2,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      viewModel.data.date.toDateString(),
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                              color:
                                                  theme.colorScheme.onSurface),
                                      maxLines: 1,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color:
                                              viewModel.data.status.toColor(),
                                          borderRadius: Dimens.radiusSmall
                                              .toBorderRadius()),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        viewModel.data.status
                                            .toLocalizedString(context),
                                        style: theme.textTheme.caption
                                            ?.copyWith(
                                                color:
                                                    theme.colorScheme.surface),
                                      ),
                                    ),
                                  ],
                                ),
                                const Separator(size: 5),
                                Divider(color: theme.highlightColor),
                                _profile(),
                                const Separator(),
                                Material(
                                  borderRadius:
                                      Dimens.radiusSmall.toBorderRadius(),
                                  color: theme.colorScheme.onBackground,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Dimens.paddingSmall),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          localization.description,
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                                  color: theme
                                                      .colorScheme.onSurface),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          viewModel.data.description,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Separator(),
                                Material(
                                  borderRadius:
                                      Dimens.radiusSmall.toBorderRadius(),
                                  color: theme.colorScheme.onBackground,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Dimens.paddingSmall),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          localization.address,
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                                  color: theme
                                                      .colorScheme.onSurface),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          viewModel.data.address,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                        const SizedBox(height: 5),
                                        viewModel.showBeginLocation
                                            ? ClipRRect(
                                                borderRadius: Dimens.radiusSmall
                                                    .toBorderRadius(),
                                                child: SizedBox(
                                                  height: 160,
                                                  child: Consumer(builder:
                                                      (context, ref, _) {
                                                    ref.watch(
                                                        reservationDetailViewModel
                                                            .select((value) =>
                                                                value
                                                                    .beginMarkers
                                                                    .length));
                                                    return GoogleMap(
                                                      onTap: (argument) => viewModel
                                                          .getBeginDirections(),
                                                      initialCameraPosition:
                                                          CameraPosition(
                                                              target: LatLng(
                                                                  viewModel
                                                                      .data
                                                                      .beginGeoPoint!
                                                                      .latitude,
                                                                  viewModel
                                                                      .data
                                                                      .beginGeoPoint!
                                                                      .longitude),
                                                              zoom: 14.5),
                                                      mapType: MapType.normal,
                                                      mapToolbarEnabled: false,
                                                      myLocationButtonEnabled:
                                                          false,
                                                      zoomControlsEnabled:
                                                          false,
                                                      zoomGesturesEnabled:
                                                          false,
                                                      scrollGesturesEnabled:
                                                          false,
                                                      markers: viewModel
                                                          .beginMarkers,
                                                      onMapCreated: viewModel
                                                          .onBeginMapCreated,
                                                    );
                                                  }),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                const Separator(),
                                Material(
                                  borderRadius:
                                      Dimens.radiusSmall.toBorderRadius(),
                                  color: theme.colorScheme.onBackground,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Dimens.paddingSmall),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          localization.destinationAddress,
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                                  color: theme
                                                      .colorScheme.onSurface),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          viewModel.data.destinationAddress,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                        const SizedBox(height: 5),
                                        viewModel.showEndLocation
                                            ? ClipRRect(
                                                borderRadius: Dimens.radiusSmall
                                                    .toBorderRadius(),
                                                child: SizedBox(
                                                  height: 160,
                                                  child: Consumer(builder:
                                                      (context, ref, _) {
                                                    ref.watch(
                                                        reservationDetailViewModel
                                                            .select((value) =>
                                                                value.endMarkers
                                                                    .length));
                                                    return GoogleMap(
                                                      onTap: (argument) =>
                                                          viewModel
                                                              .getEndDirections(),
                                                      initialCameraPosition:
                                                          CameraPosition(
                                                              target: LatLng(
                                                                  viewModel
                                                                      .data
                                                                      .endGeoPoint!
                                                                      .latitude,
                                                                  viewModel
                                                                      .data
                                                                      .endGeoPoint!
                                                                      .longitude),
                                                              zoom: 14.5),
                                                      mapType: MapType.normal,
                                                      mapToolbarEnabled: false,
                                                      myLocationButtonEnabled:
                                                          false,
                                                      zoomControlsEnabled:
                                                          false,
                                                      zoomGesturesEnabled:
                                                          false,
                                                      scrollGesturesEnabled:
                                                          false,
                                                      markers:
                                                          viewModel.endMarkers,
                                                      onMapCreated: viewModel
                                                          .onEndMapCreated,
                                                    );
                                                  }),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                const Separator(),
                                Material(
                                  borderRadius:
                                      Dimens.radiusSmall.toBorderRadius(),
                                  color: theme.colorScheme.onBackground,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Dimens.paddingSmall),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          localization.averageDistance,
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                                  color: theme
                                                      .colorScheme.onSurface),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${viewModel.data.distance.round()}${localization.km}",
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Separator(),
                                Material(
                                  borderRadius:
                                      Dimens.radiusSmall.toBorderRadius(),
                                  color: theme.colorScheme.onBackground,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Dimens.paddingSmall),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          localization.estimatedAmount,
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                                  color: theme
                                                      .colorScheme.onSurface),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${localization.turkishCurrency}${(viewModel.data.distance * viewModel.data.resPricePerKm).toStringAsFixed(2)}",
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  bottomBar()
                ],
              ),
            ),
    );
  }

  Widget _profile() => Container(
        height: 70,
        margin: const EdgeInsets.only(
            bottom: Dimens.padding, top: Dimens.paddingSmall),
        child: Material(
          color: theme.colorScheme.onBackground,
          borderRadius: Dimens.radiusSmall.toBorderRadius(),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.paddingSmall),
            child: Row(
              children: [
                ImageX(
                  "",
                  aspectRatio: 1,
                  borderRadius: Dimens.radiusSmallX.toBorderRadius(),
                ),
                const SizedBox(
                  width: Dimens.paddingSmall,
                ),
                Expanded(
                    child: Text(
                  viewModel.data.fullName,
                  style: theme.textTheme.subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                )),
              ],
            ),
          ),
        ),
      );

  Widget bottomBar() => Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            top: BorderSide(width: .5, color: theme.highlightColor),
          ),
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: Dimens.padding),
        child: bottomContent(),
      );

  Widget bottomContent() => SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              child: RezervationScheduleTile(
                  start: viewModel.data.date.toTimeOfDay(),
                  end: viewModel.data.date.toTimeOfDay().replacing(
                      hour: viewModel.data.date.toTimeOfDay().hour + 2),
                  isEmpty: null),
            ),
            const SizedBox(width: Dimens.paddingSmall),
            FloatingActionButton(
                onPressed: viewModel.call,
                child: const Icon(
                  Icons.call_rounded,
                  color: Colors.greenAccent,
                )),
            const SizedBox(width: Dimens.paddingSmall),
            FloatingActionButton(
                heroTag: null,
                onPressed: viewModel.message,
                child: const Icon(
                  Icons.message_rounded,
                  color: Colors.orangeAccent,
                ))
          ],
        ),
      );
}
