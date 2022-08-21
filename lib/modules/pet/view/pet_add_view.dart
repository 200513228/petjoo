import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/modules/pet/model/pet_advert_animals.dart';
import 'package:petjoo/modules/pet/model/pet_advert_genders.dart';
import 'package:petjoo/modules/pet/model/pet_advert_habits.dart';
import 'package:petjoo/modules/pet/model/pet_advert_infertilities.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/model/pet_advert_sizes.dart';
import 'package:petjoo/modules/pet/model/pet_advert_toilets.dart';
import 'package:petjoo/modules/pet/model/pet_advert_types.dart';
import 'package:petjoo/modules/pet/model/pet_advert_vaccines.dart';
import 'package:petjoo/modules/pet/viewmodel/pet_add_viewmodel.dart';
import 'package:petjoo/product/constants/dial_codes.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/validators.dart';

class PetAddView extends StatelessWidget {
  final PetAdvertModel? model;
  final PetAddViewModel vm = PetAddViewModel();
  PetAddView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model != null) vm.preEdit(model!);
    return Scaffold(
      appBar: buildAppBar(),
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
          validator: Validators.title('Başlık En Az 3 harfli olmalıdır.'),
          decoration: const InputDecoration(
            counterText: '',
            label: Text('Başlık'),
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
          validator:
              Validators.description('Açıklama En Az 4 harfli olmalıdır.'),
          decoration: const InputDecoration(
            label: Text('Açıklama'),
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
              validator:
                  Validators.phone('Geçerli Bir Telefon No Giriniz', true),
              decoration: InputDecoration(
                  label: const Text('Telefon'),
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
              hint: 'İlan Türü',
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
              decoration: const InputDecoration(
                counterText: '',
                label: Text('Yaş'),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: DropdownX<int>(
              value: vm.animal,
              hint: 'Tür',
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
                hint: 'Cinsiyet',
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
                hint: 'Boyut',
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
                hint: 'Huy',
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
                hint: 'Kısırlık',
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
                hint: 'Tuvalet Eğitimi',
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
                hint: 'Aşı Durumu',
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
          decoration: const InputDecoration(
            label: Text('Adres'),
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
                onPressed: () {
                  model != null ? vm.update(context) : vm.nextStep(context);
                },
                child: Text(model != null ? 'Kaydet' : 'Sonraki Adım')),
          ),
        )
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(model != null ? 'İlan Düzenle' : 'Yeni İlan'),
    );
  }
}
