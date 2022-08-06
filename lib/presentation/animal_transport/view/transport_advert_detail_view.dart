import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/infrastructure/repositories/transport_repository_impl.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/presentation/animal_transport/view_model/transport_advert_detail_view_model.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/map_argument.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/ui/tiles/shift_tile.dart';
import 'package:petjoo/product/ui/widgets/feature_widget.dart';
import 'package:petjoo/product/ui/widgets/image_x.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class TransportAdvertDetailView extends ConsumerStatefulWidget {
  final TransportAdvertModel data;
  const TransportAdvertDetailView(this.data, {Key? key}) : super(key: key);

  @override
  ConsumerStateX<TransportAdvertDetailView> createState() =>
      _TransportAdvertDetailViewState();
}

class _TransportAdvertDetailViewState
    extends ConsumerStateX<TransportAdvertDetailView> {
  late final advertDetailViewModel = ChangeNotifierProvider((ref) =>
      TransportAdvertDetailViewModel(context, TransportRepositoryImpl(),
          widget.data, ref.read(chatProvider)));

  late final viewModel = ref.read(advertDetailViewModel);

  TransportAdvertModel get data => viewModel.data;

  @override
  void initState() {
    viewModel.getMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toNavigationBar(
          theme.colorScheme.surface, Brightness.light),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.transportAdvertDetail),
          actions: [
            PopupMenuButton(
              color: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(
                  borderRadius: Dimens.radiusSmall.toBorderRadius()),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'share',
                  child: Text(localization.share),
                ),
                if (!viewModel.isOwner)
                  PopupMenuItem(
                    value: 'report',
                    child: Text(
                      localization.report,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  )
              ],
              onSelected: (value) {
                switch (value) {
                  case 'share':
                    viewModel.share();
                    break;
                  case 'report':
                    viewModel.report();
                    break;
                  default:
                }
              },
            )
          ],
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
                        preferredSize: const Size.fromHeight(Dimens.padding),
                        child: Container(
                            height: Dimens.padding,
                            decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius:
                                    Dimens.radius.toTopBorderRadius()))),
                    flexibleSpace: data.images.isEmpty
                        ? Image.asset(
                            Images.noImage,
                            fit: BoxFit.cover,
                          )
                        : PageView.builder(
                            itemCount: data.images.length,
                            itemBuilder: (context, index) => GestureDetector(
                                  child: ImageX(
                                    data.images[index],
                                  ),
                                  onTap: () => viewModel.showFullScreen(index),
                                )),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                        Dimens.padding, 0, Dimens.padding, Dimens.padding),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Text(
                            data.title,
                            style: theme.textTheme.headline6
                                ?.copyWith(color: theme.colorScheme.onSurface),
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${localization.turkishCurrency}${data.pricePerKm}/${localization.km}",
                                style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.onSurface),
                                maxLines: 1,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius:
                                        Dimens.radiusSmall.toBorderRadius()),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  localization.open,
                                  style: theme.textTheme.caption?.copyWith(
                                      color: theme.colorScheme.surface),
                                ),
                              ),
                            ],
                          ),
                          const Separator(size: 5),
                          Divider(color: theme.highlightColor),
                          _features(),
                          const Separator(),
                          Material(
                            borderRadius: Dimens.radiusSmall.toBorderRadius(),
                            color: theme.colorScheme.onBackground,
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(Dimens.paddingSmall),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    localization.description,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                        color: theme.colorScheme.onSurface),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    data.description,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Separator(),
                          Material(
                            borderRadius: Dimens.radiusSmall.toBorderRadius(),
                            color: theme.colorScheme.onBackground,
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(Dimens.paddingSmall),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    localization.location,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                        color: theme.colorScheme.onSurface),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    data.address,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 5),
                                  ClipRRect(
                                    borderRadius:
                                        Dimens.radiusSmall.toBorderRadius(),
                                    child: SizedBox(
                                      height: 160,
                                      child:
                                          Consumer(builder: (context, ref, _) {
                                        ref.watch(advertDetailViewModel.select(
                                            (value) => value.markers.length));
                                        return GoogleMap(
                                          onTap: (argument) =>
                                              viewModel.getDirections(),
                                          initialCameraPosition: data
                                                      .geoPoint !=
                                                  null
                                              ? CameraPosition(
                                                  target: LatLng(
                                                      data.geoPoint!.latitude,
                                                      data.geoPoint!.longitude),
                                                  zoom: 14.5)
                                              : const CameraPosition(
                                                  target: LatLng(
                                                      41.11611786832982,
                                                      29.06299121667866),
                                                  zoom: 8),
                                          mapType: MapType.normal,
                                          mapToolbarEnabled: false,
                                          myLocationButtonEnabled: false,
                                          zoomControlsEnabled: false,
                                          zoomGesturesEnabled: false,
                                          scrollGesturesEnabled: false,
                                          markers: viewModel.markers,
                                          onMapCreated:
                                              (GoogleMapController controller) {
                                            viewModel.mapController =
                                                controller;
                                            viewModel.mapController.setMapStyle(
                                                MapArgument.darkStyleText);
                                          },
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Separator(),
                          _shifts()
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

  Widget _features() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: FeatureWidget(
            icon: FontAwesomeIcons.earthAmericas,
            text: localization.intercity,
            iconColor: data.isIntercity
                ? null
                : theme.colorScheme.onSurface.withOpacity(.3),
          )),
          const SizedBox(width: 10),
          Flexible(
              child: FeatureWidget(
            icon: FontAwesomeIcons.shieldDog,
            text: localization.cage,
            iconColor: data.hasCage
                ? null
                : theme.colorScheme.onSurface.withOpacity(.3),
          )),
          const SizedBox(width: 10),
          Flexible(
              child: FeatureWidget(
            icon: Icons.circle_outlined,
            text: localization.collar,
            iconColor: data.hasCollar
                ? null
                : theme.colorScheme.onSurface.withOpacity(.3),
          )),
          const SizedBox(width: 10),
          Flexible(
              child: FeatureWidget(
            icon: FontAwesomeIcons.personRunning,
            text: localization.catching,
            iconColor: data.canCatch
                ? null
                : theme.colorScheme.onSurface.withOpacity(.3),
          )),
        ],
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
        child: viewModel.isOwner ? ownerBottomContent() : bottomContent(),
      );

  Widget bottomContent() {
    final isAnonymous = FirebaseAuth.instance.currentUser!.isAnonymous;

    return SafeArea(
      bottom: false,
      child: Row(
        children: [
          Expanded(
              child: Visibility(
            visible: !isAnonymous,
            child: FloatingActionButton.extended(
              heroTag: null,
              backgroundColor: theme.colorScheme.primary,
              label: Text(localization.bookNow,
                  style: TextStyle(color: theme.colorScheme.onPrimary)),
              onPressed: () => context.pushNamed(Routes.transportAdvertBooking,
                  arguments: data),
            ),
          )),
          const SizedBox(width: Dimens.paddingSmall),
          FloatingActionButton(
              elevation: data.phone.isEmpty ? 0 : null,
              onPressed: data.phone.isEmpty ? null : viewModel.call,
              child: Icon(
                Icons.call_rounded,
                color: data.phone.isEmpty ? Colors.grey : Colors.greenAccent,
              )),
          ...isAnonymous
              ? []
              : [
                  const SizedBox(width: Dimens.paddingSmall),
                  FloatingActionButton(
                      heroTag: null,
                      onPressed: viewModel.message,
                      child: const Icon(
                        Icons.message_rounded,
                        color: Colors.orangeAccent,
                      ))
                ],
        ],
      ),
    );
  }

  Widget ownerBottomContent() => SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
                child: FloatingActionButton.extended(
              heroTag: null,
              backgroundColor: theme.colorScheme.primary,
              label: Text(localization.editShifts,
                  style: TextStyle(color: theme.colorScheme.onPrimary)),
              onPressed: viewModel.editShifts,
            )),
            const SizedBox(width: Dimens.paddingSmall),
            FloatingActionButton(
                heroTag: null,
                onPressed: viewModel.edit,
                child: const Icon(
                  Icons.edit_rounded,
                  color: Colors.orangeAccent,
                )),
          ],
        ),
      );

  _shifts() {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: data.shifts.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(
              height: Dimens.paddingSmallX,
            ),
        itemBuilder: (context, index) {
          return ShiftTile(data.shifts[index]);
        });
  }
}
