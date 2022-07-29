import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/infrastructure/repositories/transport_repository_impl.dart';
import 'package:petjoo/presentation/animal_transport/view_model/transport_advert_input_view_model.dart';
import 'package:petjoo/product/constants/dial_codes.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/constants/validators.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

import '../../../product/ui/widgets/feature_widget.dart';

class TransportAdvertInputView extends ConsumerStatefulWidget {
  const TransportAdvertInputView(this.data, {Key? key}) : super(key: key);

  final TransportAdvertModel data;

  @override
  ConsumerStateX<TransportAdvertInputView> createState() => _TransportAdvertInputViewState();
}

class _TransportAdvertInputViewState extends ConsumerStateX<TransportAdvertInputView> {
  late final transportAdvertInputViewModel = ChangeNotifierProvider.autoDispose((ref) => TransportAdvertInputViewModel(context, TransportRepositoryImpl()));
  late final viewModel = ref.read(transportAdvertInputViewModel)..data = widget.data;

  @override
  void initState() {
    viewModel.getMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(transportAdvertInputViewModel.select((value) => value.isLoading));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toAll(theme.scaffoldBackgroundColor, Brightness.dark),
      child: isLoading
          ? Loading(
              background: theme.scaffoldBackgroundColor,
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(localization.myPetTransport),
              ),
              body: Form(
                key: viewModel.formKey,
                child: ListView(padding: const EdgeInsets.all(Dimens.paddingSmall), children: [
                  TextFormField(
                    controller: viewModel.titleController,
                    keyboardType: TextInputType.name,
                    maxLength: 50,
                    textInputAction: TextInputAction.next,
                    validator: Validators.title(localization.titleError),
                    decoration: InputDecoration(
                      counterText: '',
                      label: Text(localization.title),
                    ),
                  ),
                  const Separator(),
                  TextFormField(
                    controller: viewModel.descriptionController,
                    keyboardType: TextInputType.text,
                    maxLength: 255,
                    maxLines: 3,
                    textInputAction: TextInputAction.next,
                    validator: Validators.title(localization.descriptionError),
                    decoration: InputDecoration(
                      label: Text(localization.description),
                    ),
                  ),
                  const Separator(),
                  TextFormField(
                    controller: viewModel.priceController,
                    keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                    maxLength: 5,
                    textInputAction: TextInputAction.next,
                    validator: Validators.number(localization.priceError),
                    decoration: InputDecoration(counterText: '', label: Text(localization.pricePerKm), suffixText: localization.turkishCurrency),
                  ),
                  const Separator(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ValueListenableBuilder<String>(
                          valueListenable: viewModel.dialCode,
                          builder: (context, value, _) => DropdownX<String>(
                            value: value,
                            borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
                            validator: (value) => value?.isEmpty == true ? "" : null,
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
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: viewModel.phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          textInputAction: TextInputAction.next,
                          validator: Validators.phone(localization.phoneError),
                          decoration: InputDecoration(
                              counterText: '',
                              label: Text(localization.phone),
                              hintText: localization.phoneFormat,
                              border: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                              focusedBorder: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                              errorBorder: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                              focusedErrorBorder: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius())),
                        ),
                      ),
                    ],
                  ),
                  const Separator(),
                  Consumer(builder: (context, ref, _) {
                    final addressLocation = ref.watch(transportAdvertInputViewModel.select((value) => value.addressLocation));
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addressLocation == null
                            ? ButtonX(
                                width: 80,
                                height: 111.5,
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimens.radiusSmall), bottomLeft: Radius.circular(Dimens.radiusSmall)),
                                color: theme.colorScheme.secondary,
                                onTap: viewModel.selectAddressLocation,
                                child: Center(
                                  child: Text(
                                    localization.pickLocation,
                                    maxLines: 2,
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimens.radiusSmall), bottomLeft: Radius.circular(Dimens.radiusSmall)),
                                child: SizedBox(
                                  width: 80,
                                  height: 111.5,
                                  child: Consumer(builder: (context, ref, _) {
                                    final addressMarker = ref.watch(transportAdvertInputViewModel.select((value) => value.addressMarker));
                                    return GoogleMap(
                                      onTap: (argument) => viewModel.selectAddressLocation(),
                                      initialCameraPosition: CameraPosition(target: LatLng(addressLocation.latitude, addressLocation.longitude), zoom: 14),
                                      mapType: MapType.normal,
                                      mapToolbarEnabled: false,
                                      myLocationButtonEnabled: false,
                                      zoomControlsEnabled: false,
                                      zoomGesturesEnabled: false,
                                      scrollGesturesEnabled: false,
                                      markers: addressMarker == null ? {} : {addressMarker},
                                      onMapCreated: viewModel.onAddressMapCreated,
                                    );
                                  }),
                                ),
                              ),
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.addressController,
                            keyboardType: TextInputType.streetAddress,
                            maxLength: 255,
                            maxLines: 3,
                            textInputAction: TextInputAction.next,
                            validator: Validators.title(localization.addressError),
                            decoration: InputDecoration(
                              border: _inputBorder,
                              focusedBorder: _inputBorder,
                              errorBorder: _inputBorder,
                              focusedErrorBorder: _inputBorder,
                              label: Text(localization.myAddress),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const Separator(),
                  _features(),
                  const Separator(),
                  ButtonX(
                      borderRadius: Dimens.radiusSmall.toBorderRadius(),
                      margin: const EdgeInsets.only(top: Dimens.padding),
                      padding: const EdgeInsets.all(Dimens.paddingSmall),
                      color: theme.colorScheme.secondary,
                      onTap: viewModel.save,
                      child: Text(
                        localization.save,
                        textAlign: TextAlign.center,
                      ))
                ]),
              ),
            ),
    );
  }

  Widget _features() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Consumer(builder: (context, ref, _) {
            final isIntl = ref.watch(transportAdvertInputViewModel.select((value) => value.data.isIntercity));
            return GestureDetector(
              onTap: viewModel.changeIntl,
              child: FeatureWidget(
                icon: FontAwesomeIcons.earthAmericas,
                text: localization.intercity,
                iconColor: isIntl ? null : theme.colorScheme.onSurface.withOpacity(.3),
                background: isIntl ? theme.colorScheme.secondary : null,
              ),
            );
          })),
          const SizedBox(width: 10),
          Flexible(
            child: Consumer(builder: (context, ref, _) {
              final hasCage = ref.watch(transportAdvertInputViewModel.select((value) => value.data.hasCage));
              return GestureDetector(
                onTap: viewModel.changeCage,
                child: FeatureWidget(
                  icon: FontAwesomeIcons.shieldDog,
                  text: localization.cage,
                  iconColor: hasCage ? null : theme.colorScheme.onSurface.withOpacity(.3),
                  background: hasCage ? theme.colorScheme.secondary : null,
                ),
              );
            }),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Consumer(builder: (context, ref, _) {
              final hasCollar = ref.watch(transportAdvertInputViewModel.select((value) => value.data.hasCollar));
              return GestureDetector(
                onTap: viewModel.changeCollar,
                child: FeatureWidget(
                  icon: Icons.circle_outlined,
                  text: localization.collar,
                  iconColor: hasCollar ? null : theme.colorScheme.onSurface.withOpacity(.3),
                  background: hasCollar ? theme.colorScheme.secondary : null,
                ),
              );
            }),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Consumer(builder: (context, ref, _) {
              final canCatch = ref.watch(transportAdvertInputViewModel.select((value) => value.data.canCatch));
              return GestureDetector(
                onTap: viewModel.changeCatch,
                child: FeatureWidget(
                  icon: FontAwesomeIcons.personRunning,
                  text: localization.catching,
                  iconColor: canCatch ? null : theme.colorScheme.onSurface.withOpacity(.3),
                  background: canCatch ? theme.colorScheme.secondary : null,
                ),
              );
            }),
          ),
        ],
      );

  InputBorder get _inputBorder => const UnderlineInputBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(Dimens.radiusSmall), bottomRight: Radius.circular(Dimens.radiusSmall)),
        borderSide: BorderSide(color: Colors.transparent),
      );
}
