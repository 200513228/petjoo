import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/presentation/animal_advert/view_model/advert_detail_view_model.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/infrastructure/repositories/advert_repository_impl.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/map_argument.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/core/extensions/datetime_extension.dart';
import 'package:petjoo/product/models/user_basic_model.dart';
import 'package:petjoo/product/network/requests.dart';
import 'package:petjoo/product/ui/widgets/feature_widget.dart';
import 'package:petjoo/product/ui/widgets/image_x.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class AdvertDetailView extends ConsumerStatefulWidget {
  final AdvertModel data;
  const AdvertDetailView(this.data, {Key? key}) : super(key: key);

  @override
  ConsumerStateX<AdvertDetailView> createState() => _AdvertDetailViewState();
}

class _AdvertDetailViewState extends ConsumerStateX<AdvertDetailView> {
  late final advertDetailViewModel = ChangeNotifierProvider((ref) =>
      AdvertDetailViewModel(context, AdvertRepositoryImpl(), widget.data,
          ref.read(chatProvider)));
  late final viewModel = ref.read(advertDetailViewModel);

  AdvertModel get data => viewModel.data;

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
          title: Text(localization.advertDetail),
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
                          const Separator(size: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.date.toDateString(),
                                style: theme.textTheme.caption,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: data.type.toColor(),
                                    borderRadius:
                                        Dimens.radiusSmall.toBorderRadius()),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  data.type.toLocalizedString(context),
                                  style: theme.textTheme.caption
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const Separator(size: 5),
                          Divider(color: theme.highlightColor),
                          Consumer(builder: (context, ref, _) {
                            final user = ref.watch(userProvider.select(
                                (value) => value.userInfos.firstOrNullWhere(
                                    (x) => x.id == widget.data.userId)));
                            if (user == null) {
                              Requests.getUserInfo(data.userId).then((value) =>
                                  ref.read(userProvider).addUserInfo(value));
                            }
                            return _profile(user);
                          }),
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
                          data.geoPoint != null
                              ? Material(
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
                                          localization.location,
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                                  color: theme
                                                      .colorScheme.onSurface),
                                        ),
                                        const SizedBox(height: 5),
                                        ClipRRect(
                                          borderRadius: Dimens.radiusSmall
                                              .toBorderRadius(),
                                          child: SizedBox(
                                            height: 160,
                                            child: Consumer(
                                                builder: (context, ref, _) {
                                              ref.watch(advertDetailViewModel
                                                  .select((value) =>
                                                      value.markers.length));
                                              return GoogleMap(
                                                onTap: (argument) =>
                                                    viewModel.getDirections(),
                                                initialCameraPosition:
                                                    CameraPosition(
                                                        target: LatLng(
                                                            data.geoPoint!
                                                                .latitude,
                                                            data.geoPoint!
                                                                .longitude),
                                                        zoom: 14.5),
                                                mapType: MapType.normal,
                                                mapToolbarEnabled: false,
                                                myLocationButtonEnabled: false,
                                                zoomControlsEnabled: false,
                                                zoomGesturesEnabled: false,
                                                scrollGesturesEnabled: false,
                                                markers: viewModel.markers,
                                                onMapCreated:
                                                    (GoogleMapController
                                                        controller) {
                                                  viewModel.mapController =
                                                      controller;
                                                  viewModel.mapController
                                                      .setMapStyle(MapArgument
                                                          .darkStyleText);
                                                },
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
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

  Widget _features() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: FeatureWidget(
                icon: data.animalType.toIconData(),
                text: data.animalType.toLocalizedString(context),
                iconColor: Colors.orangeAccent,
              )),
              const SizedBox(width: 10),
              Flexible(
                child: FeatureWidget(
                  icon: data.animalGender.toIconData(),
                  text: data.animalGender.toLocalizedString(context),
                  iconColor: data.animalGender.toColor(),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                  child: FeatureWidget(
                icon: data.animalSize.toIconData(),
                text: data.animalSize.toLocalizedString(context),
                iconColor: Colors.lightBlueAccent,
              )),
              const SizedBox(width: 10),
              Flexible(
                  child: FeatureWidget(
                icon: Icons.cake_rounded,
                text: data.animalAge.isEmpty ? "-" : data.animalAge,
                iconColor: theme.colorScheme.primary,
              ))
            ],
          ),
          const Separator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: FeatureWidget(
                icon: data.animalHabit.toIconData(),
                text: data.animalHabit.toLocalizedString(context),
                iconColor: data.animalHabit.toColor(),
              )),
              const SizedBox(width: 10),
              Flexible(
                child: FeatureWidget(
                  icon: data.infertility.toIconData(),
                  text: data.infertility.toLocalizedString(context),
                  iconColor: data.infertility.toColor(),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                  child: FeatureWidget(
                icon: data.toiletTraining.toIconData(),
                text: data.toiletTraining.toLocalizedString(context),
                iconColor: data.toiletTraining.toColor(),
              )),
              const SizedBox(width: 10),
              Flexible(
                  child: FeatureWidget(
                icon: data.vaccine.toIconData(),
                text: data.vaccine.toLocalizedString(context),
                iconColor: data.vaccine.toColor(),
              )),
            ],
          )
        ],
      );

  Widget _profile(UserBasicModel? user) => Container(
        height: 70,
        margin: const EdgeInsets.only(
            bottom: Dimens.padding, top: Dimens.paddingSmall),
        child: Material(
          color: theme.colorScheme.onBackground,
          borderRadius: Dimens.radiusSmall.toBorderRadius(),
          child: user == null
              ? const Loading()
              : Padding(
                  padding: const EdgeInsets.all(Dimens.paddingSmall),
                  child: Row(
                    children: [
                      ImageX(
                        user.image,
                        aspectRatio: 1,
                        borderRadius: Dimens.radiusSmallX.toBorderRadius(),
                      ),
                      const SizedBox(
                        width: Dimens.paddingSmall,
                      ),
                      Expanded(
                          child: Text(
                        user.fullname,
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
        child: Consumer(
          builder: (context, ref, child) {
            final isLoading = ref.watch(
                advertDetailViewModel.select((value) => value.isLoading));
            return isLoading
                ? const SizedBox(height: 56, child: Loading())
                : viewModel.isOwner
                    ? ownerBottomContent()
                    : bottomContent();
          },
        ),
      );

  Widget bottomContent() => SafeArea(
        child: Row(
          children: [
            Expanded(
                child: FloatingActionButton.extended(
              heroTag: null,
              backgroundColor: theme.colorScheme.primary,
              label: Text(localization.getDirections,
                  style: TextStyle(color: theme.colorScheme.onPrimary)),
              onPressed: data.geoPoint == null ? null : viewModel.getDirections,
            )),
            const SizedBox(width: Dimens.paddingSmall),
            FloatingActionButton(
                elevation: data.phone.isEmpty ? 0 : null,
                onPressed: data.phone.isEmpty ? null : viewModel.call,
                child: Icon(
                  Icons.call_rounded,
                  color: data.phone.isEmpty ? Colors.grey : Colors.greenAccent,
                )),
            ...FirebaseAuth.instance.currentUser!.isAnonymous
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

  Widget ownerBottomContent() => SafeArea(
        bottom: false,
        child: Consumer(builder: (context, ref, _) {
          final isAdopted = ref.watch(
              advertDetailViewModel.select((value) => value.data.isAdopted));
          return Row(
            children: [
              ...isAdopted
                  ? [
                      Expanded(
                          child: Text(
                        localization.adopted,
                        style: const TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold),
                      ))
                    ]
                  : [
                      Expanded(
                        child: FloatingActionButton.extended(
                          heroTag: null,
                          backgroundColor: theme.colorScheme.primary,
                          label: Text(localization.markAdopted,
                              style: TextStyle(
                                  color: theme.colorScheme.onPrimary)),
                          onPressed: viewModel.adaptionWarning,
                        ),
                      ),
                      const SizedBox(width: Dimens.paddingSmall),
                      FloatingActionButton(
                          onPressed: viewModel.edit,
                          child: const Icon(
                            Icons.edit_rounded,
                            color: Colors.orangeAccent,
                          )),
                    ],
              const SizedBox(width: Dimens.paddingSmall),
              FloatingActionButton(
                  heroTag: null,
                  onPressed: viewModel.sureFordelete,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  )),
            ],
          );
        }),
      );
}
