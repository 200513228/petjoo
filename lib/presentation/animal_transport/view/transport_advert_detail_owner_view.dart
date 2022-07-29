import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/infrastructure/repositories/transport_repository_impl.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/ui/widgets/image_x.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';
import '../../../product/ui/tiles/shift_tile.dart';
import '../../../product/ui/widgets/feature_widget.dart';
import '../view_model/transport_advert_detail_owner_view_model.dart';

class TransportAdvertDetailOwnerView extends ConsumerStatefulWidget {
  const TransportAdvertDetailOwnerView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<TransportAdvertDetailOwnerView> createState() => _TransportAdvertDetailOwnerViewState();
}

class _TransportAdvertDetailOwnerViewState extends ConsumerStateX<TransportAdvertDetailOwnerView> {
  late final transportAdvertDetailOwnerViewModel =
      ChangeNotifierProvider((ref) => TransportAdvertDetailOwnerViewModel(context, TransportRepositoryImpl(), ref.read(userProvider)));

  late final viewModel = ref.read(transportAdvertDetailOwnerViewModel);

  TransportAdvertModel get data => viewModel.data!;

  @override
  void initState() {
    viewModel.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDataLoading = ref.watch(transportAdvertDetailOwnerViewModel.select((value) => value.data == null));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDataLoading
          ? OverlayStyles.toNavigationBar(theme.colorScheme.background, Brightness.dark)
          : OverlayStyles.toNavigationBar(theme.colorScheme.surface, Brightness.light),
      child: isDataLoading
          ? Loading(
              background: theme.colorScheme.background,
            )
          : Scaffold(
              appBar: AppBar(title: Text(localization.myPetTransport), actions: [
                PopupMenuButton(
                  color: theme.colorScheme.surface,
                  shape: RoundedRectangleBorder(borderRadius: Dimens.radiusSmall.toBorderRadius()),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'share',
                      child: Text(localization.share),
                    ),
                  ],
                  onSelected: (value) {
                    switch (value) {
                      case 'share':
                        viewModel.share();
                        break;
                    }
                  },
                )
              ]),
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
                                  decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: Dimens.radius.toTopBorderRadius()))),
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
                          padding: const EdgeInsets.fromLTRB(Dimens.padding, 0, Dimens.padding, Dimens.padding),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Text(
                                  data.title,
                                  style: theme.textTheme.headline6?.copyWith(color: theme.colorScheme.onSurface),
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
                                      style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurface),
                                      maxLines: 1,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(color: Colors.greenAccent, borderRadius: Dimens.radiusSmall.toBorderRadius()),
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      child: Text(
                                        localization.open,
                                        style: theme.textTheme.caption?.copyWith(color: theme.colorScheme.surface),
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
                                    padding: const EdgeInsets.all(Dimens.paddingSmall),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          localization.description,
                                          style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onSurface),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data.description,
                                          style: theme.textTheme.bodySmall,
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
            iconColor: data.isIntercity ? null : theme.colorScheme.onSurface.withOpacity(.3),
          )),
          const SizedBox(width: 10),
          Flexible(
              child: FeatureWidget(
            icon: FontAwesomeIcons.shieldDog,
            text: localization.cage,
            iconColor: data.hasCage ? null : theme.colorScheme.onSurface.withOpacity(.3),
          )),
          const SizedBox(width: 10),
          Flexible(
              child: FeatureWidget(
            icon: Icons.circle_outlined,
            text: localization.collar,
            iconColor: data.hasCollar ? null : theme.colorScheme.onSurface.withOpacity(.3),
          )),
          const SizedBox(width: 10),
          Flexible(
              child: FeatureWidget(
            icon: FontAwesomeIcons.personRunning,
            text: localization.catching,
            iconColor: data.canCatch ? null : theme.colorScheme.onSurface.withOpacity(.3),
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: Dimens.padding),
      child: bottomContent());

  Widget bottomContent() => Row(
        children: [
          Expanded(
              child: Visibility(
            visible: viewModel.data?.id != null,
            child: FloatingActionButton.extended(
              heroTag: null,
              backgroundColor: theme.colorScheme.primary,
              label: Text(localization.editShifts, style: TextStyle(color: theme.colorScheme.onPrimary)),
              onPressed: viewModel.editShifts,
            ),
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
      );

  _shifts() {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: data.shifts.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(
              height: Dimens.radiusSmallX,
            ),
        itemBuilder: (context, index) {
          return ShiftTile(data.shifts[index]);
        });
  }
}
