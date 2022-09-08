import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/num_extension.dart';
import 'package:petjoo/ui/dropdown_x.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/base/string_converters.dart';
import 'package:petjoo/pet/model/pet_advert_animals.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/reservation/viewmodel/reservation_create_viewmodel.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/constants/dial_codes.dart';
import 'package:petjoo/constants/dimens.dart';
import 'package:petjoo/base/validators.dart';

class ReservationCreateView extends StatelessWidget {
  final ReservationCreateViewModel vm = ReservationCreateViewModel();
  final TransportAdvertModel advertModel;
  final ReservationModel model;
  ReservationCreateView(
      {required this.advertModel, required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    vm.setModels(model, advertModel);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(appBarTitle),
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
                      mapSelectors(context),
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
                      nextStepButton(context),
                    ],
                  ),
                ),
              );
      },
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
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: colorPalette['secondary'],
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(child: Text('Başlangıç Konumu Seç'.tr())),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: colorPalette['secondary'],
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(child: Text('Bitiş Konumu Seç'.tr())),
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
                onPressed: () => vm.save(context), child: Text('save'.tr())),
          ),
        )
      ],
    );
  }

  String get appBarTitle =>
      '${dateToString(model.date)}  ${hourToString('${model.date.toDate().hour}:${model.date.toDate().minute}')}';
}
