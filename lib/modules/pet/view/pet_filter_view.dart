import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/base/num_extension.dart';
import 'package:petjoo/ui/dropdown_x.dart';
import 'package:petjoo/modules/pet/model/pet_advert_animals.dart';
import 'package:petjoo/modules/pet/model/pet_advert_genders.dart';
import 'package:petjoo/modules/pet/model/pet_advert_habits.dart';
import 'package:petjoo/modules/pet/model/pet_advert_infertilities.dart';
import 'package:petjoo/modules/pet/model/pet_advert_sizes.dart';
import 'package:petjoo/modules/pet/model/pet_advert_toilets.dart';
import 'package:petjoo/modules/pet/model/pet_advert_types.dart';
import 'package:petjoo/modules/pet/model/pet_advert_vaccines.dart';
import 'package:petjoo/modules/pet/viewmodel/pet_filter_viewmodel.dart';
import 'package:petjoo/constants/dimens.dart';

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
            Row(
              children: [
                Expanded(
                  child: DropdownX<int>(
                    value: vm.advertType,
                    hint: 'category'.tr(),
                    label: 'category'.tr(),
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                    items: petFilterTypes.keys
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(petFilterTypes[e]!),
                            ))
                        .toList(),
                    onChanged: (value) => vm.advertType = value,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownX<int>(
                    value: vm.animalType,
                    hint: 'type'.tr(),
                    label: 'type'.tr(),
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                    items: petFilterAnimals.keys
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(petFilterAnimals[e]!),
                            ))
                        .toList(),
                    onChanged: (value) => vm.animalType = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownX<int>(
                    value: vm.animalGender,
                    hint: 'gender'.tr(),
                    label: 'gender'.tr(),
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                    items: petFilterGenders.keys
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(petFilterGenders[e]!),
                            ))
                        .toList(),
                    onChanged: (value) => vm.animalGender = value,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownX<int>(
                    value: vm.animalHabit,
                    hint: 'habit'.tr(),
                    label: 'habit'.tr(),
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                    items: petFilterHabits.keys
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(petFilterHabits[e]!),
                            ))
                        .toList(),
                    onChanged: (value) => vm.animalHabit = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownX<int>(
                    value: vm.animalSize,
                    hint: 'size'.tr(),
                    label: 'size'.tr(),
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                    items: petFilterSizes.keys
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(petFilterSizes[e]!),
                            ))
                        .toList(),
                    onChanged: (value) => vm.animalSize = value,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownX<int>(
                    value: vm.vaccine,
                    hint: 'vaccine'.tr(),
                    label: 'vaccine'.tr(),
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                    items: petFilterVaccines.keys
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(petFilterVaccines[e]!),
                            ))
                        .toList(),
                    onChanged: (value) => vm.vaccine = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownX<int>(
                    value: vm.infertility,
                    hint: 'infertility'.tr(),
                    label: 'infertility'.tr(),
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                    items: petFilterInfertilities.keys
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(petFilterInfertilities[e]!),
                            ))
                        .toList(),
                    onChanged: (value) => vm.infertility = value,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownX<int>(
                    value: vm.toilet,
                    hint: 'toilet'.tr(),
                    label: 'toilet'.tr(),
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                    items: petFilterToilets.keys
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(petFilterToilets[e]!),
                            ))
                        .toList(),
                    onChanged: (value) => vm.toilet = value,
                  ),
                ),
              ],
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
            child: Text('reset'.tr(),
                style: const TextStyle(color: Colors.redAccent)),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: ElevatedButton(
            onPressed: () => vm.setFilter(context),
            child: Text('apply'.tr()),
          ),
        )
      ],
    );
  }
}
