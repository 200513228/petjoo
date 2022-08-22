import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/modules/pet/model/pet_advert_animals.dart';
import 'package:petjoo/modules/pet/model/pet_advert_genders.dart';
import 'package:petjoo/modules/pet/model/pet_advert_habits.dart';
import 'package:petjoo/modules/pet/model/pet_advert_infertilities.dart';
import 'package:petjoo/modules/pet/model/pet_advert_sizes.dart';
import 'package:petjoo/modules/pet/model/pet_advert_toilets.dart';
import 'package:petjoo/modules/pet/model/pet_advert_types.dart';
import 'package:petjoo/modules/pet/model/pet_advert_vaccines.dart';
import 'package:petjoo/modules/pet/viewmodel/pet_filter_viewmodel.dart';
import 'package:petjoo/product/constants/dimens.dart';

class PetFilterView extends StatelessWidget {
  final PetFilterViewModel vm = PetFilterViewModel();
  PetFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setCurrent();
    return Observer(
      builder: (context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownX<int>(
              value: vm.advertType,
              hint: 'Kategori',
              label: 'Kategori',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petFilterTypes.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petFilterTypes[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.advertType = value,
            ),
            const SizedBox(height: 10),
            DropdownX<int>(
              value: vm.animalType,
              hint: 'Tür',
              label: 'Tür',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petFilterAnimals.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petFilterAnimals[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.animalType = value,
            ),
            const SizedBox(height: 10),
            DropdownX<int>(
              value: vm.animalGender,
              hint: 'Cinsiyet',
              label: 'Cinsiyet',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petFilterGenders.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petFilterGenders[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.animalGender = value,
            ),
            const SizedBox(height: 10),
            DropdownX<int>(
              value: vm.animalHabit,
              hint: 'Huy',
              label: 'Huy',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petFilterHabits.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petFilterHabits[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.animalHabit = value,
            ),
            const SizedBox(height: 10),
            DropdownX<int>(
              value: vm.animalSize,
              hint: 'Boyut',
              label: 'Boyut',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petFilterSizes.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petFilterSizes[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.animalSize = value,
            ),
            const SizedBox(height: 10),
            DropdownX<int>(
              value: vm.vaccine,
              hint: 'Aşı',
              label: 'Aşı',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petFilterVaccines.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petFilterVaccines[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.vaccine = value,
            ),
            const SizedBox(height: 10),
            DropdownX<int>(
              value: vm.infertility,
              hint: 'Kısırlık',
              label: 'Kısırlık',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petFilterInfertilities.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petFilterInfertilities[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.infertility = value,
            ),
            const SizedBox(height: 10),
            DropdownX<int>(
              value: vm.toilet,
              hint: 'Tuvalet Eğitimi',
              label: 'Tuvalet Eğitimi',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petFilterToilets.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petFilterToilets[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.toilet = value,
            ),
            const SizedBox(height: 10),
            buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => vm.resetFilter(context),
            child: const Text('Sıfırla',
                style: TextStyle(color: Colors.redAccent)),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            onPressed: () => vm.setFilter(context),
            child: const Text('Uygula'),
          ),
        )
      ],
    );
  }
}
