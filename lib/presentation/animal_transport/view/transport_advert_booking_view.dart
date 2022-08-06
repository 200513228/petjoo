import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/datetime_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/domain/enums/advert/animals.dart';
import 'package:petjoo/domain/enums/shift/days.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/infrastructure/repositories/transport_reservation_repository_impl.dart';
import 'package:petjoo/presentation/animal_transport/view_model/transport_advert_booking_view_model.dart';
import 'package:petjoo/product/constants/dial_codes.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/constants/validators.dart';
import 'package:petjoo/product/ui/tiles/rezervation_schedule_tile.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class TransportAdvertBookingView extends ConsumerStatefulWidget {
  const TransportAdvertBookingView(this.data, {Key? key}) : super(key: key);

  final TransportAdvertModel data;

  @override
  ConsumerStateX<TransportAdvertBookingView> createState() =>
      _TransportAdvertBookingViewState();
}

class _TransportAdvertBookingViewState
    extends ConsumerStateX<TransportAdvertBookingView>
    with SingleTickerProviderStateMixin {
  late final transportAdvertBookingViewModel = ChangeNotifierProvider((ref) =>
      TransportAdvertBookingViewmodel(
          context, TransportReservationRepositoryImpl()));
  late final viewModel = ref.read(transportAdvertBookingViewModel)
    ..data = widget.data;

  late final tabController = TabController(length: 7, vsync: this);
  TransportAdvertModel get data => viewModel.data;

  @override
  void initState() {
    viewModel.createTabs();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    ref.invalidate(transportAdvertBookingViewModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toNavigationBar(
          theme.colorScheme.surface, Brightness.light),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.bookNow),
        ),
        body: Material(
          color: theme.colorScheme.surface,
          borderRadius: Dimens.radius.toTopBorderRadius(),
          child: PageView(
            controller: viewModel.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [_schedule(), _userInfo()],
          ),
        ),
      ),
    );
  }

  Widget _schedule() {
    return Consumer(builder: (context, ref, _) {
      final isDataFetched = ref.watch(transportAdvertBookingViewModel
          .select((value) => value.tabList.isNotEmpty));
      return !isDataFetched
          ? const Loading()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: Dimens.paddingSmallX),
                  child: TabBar(
                      isScrollable: true,
                      controller: tabController,
                      indicatorColor: theme.colorScheme.primary,
                      onTap: viewModel.changeTab,
                      tabs: viewModel.tabList
                          .map((x) => Tab(
                                height: 56,
                                child: Text(
                                  "${x.day.toDateString()}\n${Days.values[x.day.weekday - 1].toLocalizedString(context)}",
                                  textAlign: TextAlign.center,
                                ),
                              ))
                          .toList()),
                ),
                Expanded(
                    child: TabBarView(
                        controller: tabController,
                        children: viewModel.tabList
                            .map((e) => rezervationListView(e))
                            .toList()))
              ],
            );
    });
  }

  Widget rezervationListView(ReservationTab currentDay) {
    final dayShift = data.shifts
        .firstWhere((x) => x.day.index == currentDay.day.weekday - 1);
    final today = DateTime.now();
    final todayHour = today.toTimeOfDay().hour;
    int fixedStart =
        dayShift.start.hour > todayHour || today.day != currentDay.day.day
            ? dayShift.start.hour
            : todayHour + ((todayHour - dayShift.start.hour) % 2);
    final shiftCount = ((fixedStart - dayShift.end.hour).abs() / 2).floor();
    return ListView.separated(
      itemCount: shiftCount,
      padding: const EdgeInsets.all(Dimens.padding),
      itemBuilder: (context, index) {
        final fixedStartHour = fixedStart + index * 2;
        final start = TimeOfDay(
            hour: fixedStartHour > 23 ? (fixedStartHour - 24) : fixedStartHour,
            minute: dayShift.start.minute);
        final end = TimeOfDay(
            hour: start.hour >= 22 ? (start.hour - 22) : start.hour + 2,
            minute: start.minute);
        final isEmpty = !currentDay.reservations.any(
            (x) => x.date.hour == start.hour && x.date.minute == start.minute);
        return RezervationScheduleTile(
          start: start,
          end: end,
          isEmpty: isEmpty,
          onTap: () => viewModel.selectDate(currentDay.day, start),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: Dimens.paddingSmall,
      ),
    );
  }

  _userInfo() {
    return Column(
      children: [
        Expanded(
          child: Form(
            key: viewModel.formKey,
            child: ListView(
              padding: const EdgeInsets.all(Dimens.padding),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 70,
                        child: ValueListenableBuilder<String>(
                          valueListenable: viewModel.dialCode,
                          builder: (context, value, _) => DropdownX<String>(
                            value: value,
                            color: theme.colorScheme.onBackground,
                            borderRadius:
                                Dimens.radiusSmall.toLeftBorderRadius(),
                            validator: (value) =>
                                value?.isEmpty == true ? "" : null,
                            items: dialCodes.values
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        height: 70,
                        child: TextFormField(
                          controller: viewModel.phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator:
                              Validators.phone(localization.phoneError, true),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            label: Text(localization.phone),
                            hintText: localization.phoneFormat,
                            fillColor: theme.colorScheme.onBackground,
                            border: UnderlineInputBorder(
                                borderRadius:
                                    Dimens.radiusSmall.toRightBorderRadius()),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius:
                                    Dimens.radiusSmall.toRightBorderRadius()),
                            errorBorder: UnderlineInputBorder(
                                borderRadius:
                                    Dimens.radiusSmall.toRightBorderRadius()),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderRadius:
                                    Dimens.radiusSmall.toRightBorderRadius()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Separator(),
                ValueListenableBuilder<Animals>(
                    valueListenable: viewModel.animalType,
                    builder: (context, value, _) => DropdownX<Animals>(
                          value: value,
                          hintValue: Animals.none,
                          hint: localization.type,
                          color: theme.colorScheme.onBackground,
                          validator: (value) => value?.index == 0 ? "" : null,
                          items: Animals.values
                              .sublist(1)
                              .map((animal) => DropdownMenuItem(
                                  value: animal,
                                  child: Text(
                                    animal.toLocalizedString(context),
                                  )))
                              .toList(),
                          onChanged: (value) =>
                              viewModel.animalType.value = value!,
                        )),
                const Separator(),
                TextFormField(
                  controller: viewModel.fullNameController,
                  keyboardType: TextInputType.name,
                  maxLength: 50,
                  textInputAction: TextInputAction.next,
                  validator: Validators.title(localization.nameError),
                  decoration: InputDecoration(
                      label: Text(localization.name),
                      counterText: '',
                      fillColor: theme.colorScheme.onBackground,
                      counterStyle:
                          TextStyle(color: theme.colorScheme.onSurface)),
                ),
                const Separator(),
                Consumer(builder: (context, ref, _) {
                  final beginLocation = ref.watch(
                      transportAdvertBookingViewModel
                          .select((value) => value.beginLocation));
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      beginLocation == null
                          ? ButtonX(
                              width: 80,
                              height: 120,
                              borderRadius:
                                  Dimens.radiusSmall.toLeftBorderRadius(),
                              color: theme.colorScheme.primary,
                              onTap: viewModel.selectBeginLocation,
                              child: Center(
                                child: Text(
                                  localization.pickLocation,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: theme.colorScheme.onPrimary),
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius:
                                  Dimens.radiusSmall.toLeftBorderRadius(),
                              child: SizedBox(
                                width: 80,
                                height: 120,
                                child: GoogleMap(
                                  onTap: (argument) =>
                                      viewModel.selectBeginLocation(),
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(beginLocation.latitude,
                                          beginLocation.longitude),
                                      zoom: 14),
                                  mapType: MapType.normal,
                                  mapToolbarEnabled: false,
                                  myLocationButtonEnabled: false,
                                  zoomControlsEnabled: false,
                                  zoomGesturesEnabled: false,
                                  scrollGesturesEnabled: false,
                                  markers: {viewModel.beginMarker!},
                                  onMapCreated: viewModel.onBeginMapCreated,
                                ),
                              ),
                            ),
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: TextFormField(
                            controller: viewModel.addressController,
                            keyboardType: TextInputType.streetAddress,
                            maxLines: 3,
                            textInputAction: TextInputAction.next,
                            validator:
                                Validators.title(localization.addressError),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(255),
                            ],
                            decoration: InputDecoration(
                              border: _inputBorder,
                              focusedBorder: _inputBorder,
                              errorBorder: _inputBorder,
                              focusedErrorBorder: _inputBorder,
                              label: Text(localization.address),
                              fillColor: theme.colorScheme.onBackground,
                              counterStyle:
                                  TextStyle(color: theme.colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const Separator(),
                Consumer(builder: (context, ref, _) {
                  final endLocation = ref.watch(transportAdvertBookingViewModel
                      .select((value) => value.endLocation));
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      endLocation == null
                          ? ButtonX(
                              width: 80,
                              height: 120,
                              borderRadius:
                                  Dimens.radiusSmall.toLeftBorderRadius(),
                              color: theme.colorScheme.primary,
                              onTap: viewModel.selectEndLocation,
                              child: Center(
                                child: Text(
                                  localization.pickLocation,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: theme.colorScheme.onPrimary),
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius:
                                  Dimens.radiusSmall.toLeftBorderRadius(),
                              child: SizedBox(
                                width: 80,
                                height: 120,
                                child: GoogleMap(
                                  onTap: (argument) =>
                                      viewModel.selectEndLocation(),
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(endLocation.latitude,
                                          endLocation.longitude),
                                      zoom: 14),
                                  mapType: MapType.normal,
                                  mapToolbarEnabled: false,
                                  myLocationButtonEnabled: false,
                                  zoomControlsEnabled: false,
                                  zoomGesturesEnabled: false,
                                  scrollGesturesEnabled: false,
                                  markers: {viewModel.endMarker!},
                                  onMapCreated: viewModel.onEndMapCreated,
                                ),
                              ),
                            ),
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: TextFormField(
                            controller: viewModel.destinationAddressController,
                            keyboardType: TextInputType.streetAddress,
                            maxLines: 3,
                            textInputAction: TextInputAction.next,
                            validator:
                                Validators.title(localization.addressError),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(255),
                            ],
                            decoration: InputDecoration(
                              border: _inputBorder,
                              focusedBorder: _inputBorder,
                              errorBorder: _inputBorder,
                              focusedErrorBorder: _inputBorder,
                              label: Text(localization.destinationAddress),
                              fillColor: theme.colorScheme.onBackground,
                              counterStyle:
                                  TextStyle(color: theme.colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const Separator(),
                TextFormField(
                  controller: viewModel.descriptionController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  maxLines: 3,
                  validator:
                      Validators.description(localization.descriptionError),
                  decoration: InputDecoration(
                    label: Text(localization.description),
                    fillColor: theme.colorScheme.onBackground,
                    counterStyle: TextStyle(color: theme.colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: ButtonX(
              width: double.maxFinite,
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              margin: const EdgeInsets.symmetric(
                  horizontal: Dimens.padding, vertical: Dimens.paddingSmall),
              padding: const EdgeInsets.all(Dimens.paddingSmall),
              color: theme.colorScheme.primary,
              onTap: viewModel.save,
              child: Text(
                localization.save,
                textAlign: TextAlign.center,
                style: TextStyle(color: theme.colorScheme.onPrimary),
              )),
        )
      ],
    );
  }

  InputBorder get _inputBorder => UnderlineInputBorder(
        borderRadius: Dimens.radiusSmall.toRightBorderRadius(),
        borderSide: const BorderSide(color: Colors.transparent),
      );
}
