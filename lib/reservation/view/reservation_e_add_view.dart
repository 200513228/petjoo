import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/base/num_extension.dart';
import 'package:petjoo/base/validators.dart';
import 'package:petjoo/constants/dial_codes.dart';
import 'package:petjoo/constants/dimens.dart';
import 'package:petjoo/pet/model/pet_advert_animals.dart';
import 'package:petjoo/reservation/viewmodel/reservation_e_add_viewmodel.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/ui/dropdown_x.dart';
import 'package:petjoo/ui/loading.dart';

class ReservationEAddView extends StatelessWidget {
  final ReservationEAddViewModel vm = ReservationEAddViewModel();
  final TransportAdvertModel advertModel;
  ReservationEAddView(this.advertModel, {super.key});

  @override
  Widget build(BuildContext context) {
    vm.advertModel = advertModel;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text('ACİL PET NAKİL'),
        centerTitle: true,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Observer(
      builder: (_) {
        return vm.isLoading
            ? const Center(
                child: Loading(),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: vm.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            controller: vm.nameCont,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: Validators.title('name_min3'.tr()),
                            maxLength: 30,
                            decoration: InputDecoration(
                              counterText: '',
                              label: Text('name'.tr()),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: DropdownX<String>(
                                value: vm.dialCode,
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
                                onChanged: (value) => vm.dialCode = value,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                controller: vm.phoneCont,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: Validators.phone(
                                    'register_phone_valid'.tr(), true),
                                decoration: InputDecoration(
                                    label: Text('phone'.tr()),
                                    hintText: '5xx xxx xx xx',
                                    counterText: '',
                                    border: UnderlineInputBorder(
                                        borderRadius: Dimens.radiusSmall
                                            .toRightBorderRadius()),
                                    focusedBorder: UnderlineInputBorder(
                                        borderRadius: Dimens.radiusSmall
                                            .toRightBorderRadius()),
                                    errorBorder: UnderlineInputBorder(
                                        borderRadius: Dimens.radiusSmall
                                            .toRightBorderRadius()),
                                    focusedErrorBorder: UnderlineInputBorder(
                                        borderRadius: Dimens.radiusSmall
                                            .toRightBorderRadius())),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: DropdownX<int>(
                            value: vm.animal,
                            hint: 'type'.tr(),
                            borderRadius: Dimens.radiusSmall.toBorderRadius(),
                            items: petAdvertAnimals.keys
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(petAdvertAnimals[e]!),
                                    ))
                                .toList(),
                            onChanged: (value) => vm.animal = value,
                          ),
                        ),
                        // mapSelectors(context),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: vm.descCont,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            maxLength: 500,
                            maxLines: 5,
                            decoration: InputDecoration(
                              label: Text('description'.tr()),
                            ),
                          ),
                        ),
                        callInfo(),
                        mapSelectors(context),
                        nextStepButton(context),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget callInfo() {
    return SwitchListTile(
      value: vm.call,
      onChanged: (value) => vm.call = value,
      activeColor: Colors.black,
      inactiveThumbColor: Colors.grey.shade700,
      activeTrackColor: Colors.yellow,
      inactiveTrackColor: Colors.yellow,
      title: Row(
        children: const [
          Icon(Icons.call, color: Colors.white),
          SizedBox(width: 10),
          Text('Arayıp bilgi verdim'),
        ],
      ),
    );
  }

  Widget mapSelectors(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => vm.setBegin(context),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: colorPalette['secondary'],
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: vm.beginGeoPoint != null
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: GoogleMap(
                          onTap: (arg) => vm.setBegin(context),
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(vm.beginGeoPoint!.latitude,
                                  vm.beginGeoPoint!.longitude),
                              zoom: 14),
                          markers: {
                            Marker(
                              markerId: const MarkerId('begin'),
                              position: LatLng(vm.beginGeoPoint!.latitude,
                                  vm.beginGeoPoint!.longitude),
                            )
                          },
                        ),
                      )
                    : Center(child: Text('pick_begin_point'.tr())),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => vm.setEnd(context),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: colorPalette['secondary'],
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: vm.endGeoPoint != null
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: GoogleMap(
                          onTap: (arg) => vm.setEnd(context),
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(vm.endGeoPoint!.latitude,
                                  vm.endGeoPoint!.longitude),
                              zoom: 14),
                          markers: {
                            Marker(
                              markerId: const MarkerId('begin'),
                              position: LatLng(vm.endGeoPoint!.latitude,
                                  vm.endGeoPoint!.longitude),
                            )
                          },
                        ),
                      )
                    : Center(child: Text('pick_end_point'.tr())),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget nextStepButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
                onPressed: () async {
                  await vm.save(context).then((value) {
                    value == 'SHOW'
                        ? showDialog(
                            context: context,
                            builder: (context) => alertSave(context))
                        : null;
                  });
                },
                child: Text('save'.tr())),
          ),
        )
      ],
    );
  }

  Widget alertSave(BuildContext context) {
    return AlertDialog(
      title: Text('accept'.tr()),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: Text('close'.tr())),
        ElevatedButton(
            onPressed: () => vm.calculateAndSave(context),
            child: Text('save'.tr())),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              '${'estimated_distance'.tr()}: ${(vm.model.distanceA + vm.model.distanceB) * 2} km'),
          Text(
              '${'estimated_price'.tr()}: ${((vm.model.distanceA + vm.model.distanceB) * 2 * advertModel.pricePerKm).toStringAsFixed(2)} ₺'),
        ],
      ),
    );
  }
}
