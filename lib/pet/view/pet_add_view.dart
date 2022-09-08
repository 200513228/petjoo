import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/num_extension.dart';
import 'package:petjoo/ui/dropdown_x.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/pet/model/pet_advert_animals.dart';
import 'package:petjoo/pet/model/pet_advert_genders.dart';
import 'package:petjoo/pet/model/pet_advert_habits.dart';
import 'package:petjoo/pet/model/pet_advert_infertilities.dart';
import 'package:petjoo/pet/model/pet_advert_model.dart';
import 'package:petjoo/pet/model/pet_advert_sizes.dart';
import 'package:petjoo/pet/model/pet_advert_toilets.dart';
import 'package:petjoo/pet/model/pet_advert_types.dart';
import 'package:petjoo/pet/model/pet_advert_vaccines.dart';
import 'package:petjoo/pet/viewmodel/pet_add_viewmodel.dart';
import 'package:petjoo/constants/dial_codes.dart';
import 'package:petjoo/constants/dimens.dart';
import 'package:petjoo/base/validators.dart';

class PetAddView extends StatelessWidget {
  final PetAdvertModel? model;
  final PetAddViewModel vm = PetAddViewModel();
  PetAddView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model != null) vm.preEdit(model!);
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: vm.isLoading
            ? const Center(child: Loading())
            : Form(
                key: vm.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...advertTiles,
                      const SizedBox(height: 20),
                      ...petTiles,
                      nextStepButton(context),
                    ],
                  ),
                ),
              ),
      );
    });
  }

  List<Widget> get advertTiles {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: vm.titleCont,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          maxLength: 30,
          validator: Validators.title('title_min3'.tr()),
          decoration: InputDecoration(
            counterText: '',
            label: Text('title'.tr()),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: vm.descCont,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          maxLength: 500,
          maxLines: 5,
          validator: Validators.description('desc_min4'.tr()),
          decoration: InputDecoration(
            label: Text('description'.tr()),
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
              borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
              validator: (value) => value?.isEmpty == true ? "" : null,
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
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: Validators.phone('register_phone_valid'.tr(), true),
              decoration: InputDecoration(
                  label: Text('phone'.tr()),
                  hintText: '5xx xxx xx xx',
                  counterText: '',
                  border: UnderlineInputBorder(
                      borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                  errorBorder: UnderlineInputBorder(
                      borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                  focusedErrorBorder: UnderlineInputBorder(
                      borderRadius: Dimens.radiusSmall.toRightBorderRadius())),
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> get petTiles {
    return [
      Row(
        children: [
          Expanded(
            child: DropdownX<int>(
              value: vm.type,
              hint: 'advert_type'.tr(),
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petAdvertTypes.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petAdvertTypes[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.type = value,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: vm.ageCont,
              maxLength: 9,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                counterText: '',
                label: Text('age'.tr()),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: DropdownX<int>(
              value: vm.animal,
              hint: 'type'.tr(),
              borderRadius: Dimens.radiusSmall.toRightBorderRadius(),
              items: petAdvertAnimals.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petAdvertAnimals[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.animal = value,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: DropdownX<int>(
                value: vm.gender,
                hint: 'gender'.tr(),
                borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
                items: petAdvertGenders.keys
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(petAdvertGenders[e]!),
                        ))
                    .toList(),
                onChanged: (value) => vm.gender = value,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: DropdownX<int>(
                value: vm.size,
                hint: 'size'.tr(),
                borderRadius: Dimens.radiusSmall.toRightBorderRadius(),
                items: petAdvertSizes.keys
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(petAdvertSizes[e]!),
                        ))
                    .toList(),
                onChanged: (value) => vm.size = value,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: DropdownX<int>(
                value: vm.habit,
                hint: 'habit'.tr(),
                borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
                items: petAdvertHabits.keys
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(petAdvertHabits[e]!),
                        ))
                    .toList(),
                onChanged: (value) => vm.habit = value,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: DropdownX<int>(
                value: vm.infertility,
                hint: 'infertility'.tr(),
                borderRadius: Dimens.radiusSmall.toRightBorderRadius(),
                items: petAdvertInfertilities.keys
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(petAdvertInfertilities[e]!),
                        ))
                    .toList(),
                onChanged: (value) => vm.infertility = value,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: DropdownX<int>(
                value: vm.toilet,
                hint: 'toilet'.tr(),
                borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
                items: petAdvertToilets.keys
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(petAdvertToilets[e]!),
                        ))
                    .toList(),
                onChanged: (value) => vm.toilet = value,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: DropdownX<int>(
                value: vm.vaccine,
                hint: 'vaccine'.tr(),
                borderRadius: Dimens.radiusSmall.toRightBorderRadius(),
                items: petAdvertVaccines.keys
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(petAdvertVaccines[e]!),
                        ))
                    .toList(),
                onChanged: (value) => vm.vaccine = value,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextFormField(
          controller: vm.addressCont,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          maxLength: 500,
          maxLines: 4,
          decoration: InputDecoration(
            label: Text('address'.tr()),
          ),
        ),
      ),
    ];
  }

  Widget nextStepButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
                onPressed: () => vm.nextStep(context),
                child: Text('next_step'.tr())),
          ),
        )
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      centerTitle: true,
      title: Text(
          model != null ? 'edit_advert_title'.tr() : 'new_advert_title'.tr()),
    );
  }
}
