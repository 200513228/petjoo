import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/num_extension.dart';
import 'package:petjoo/base/validators.dart';
import 'package:petjoo/constants/dial_codes.dart';
import 'package:petjoo/constants/dimens.dart';
import 'package:petjoo/pet/model/pet_advert_animals.dart';
import 'package:petjoo/reservation/viewmodel/reservation_e_add_viewmodel.dart';
import 'package:petjoo/ui/dropdown_x.dart';
import 'package:petjoo/ui/loading.dart';

class ReservationEAddView extends StatelessWidget {
  final ReservationEAddViewModel vm = ReservationEAddViewModel();
  ReservationEAddView({super.key});

  @override
  Widget build(BuildContext context) {
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
                        // nextStepButton(context),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
