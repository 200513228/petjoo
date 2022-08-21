import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/modules/pet/model/pet_advert_animals.dart';
import 'package:petjoo/modules/pet/model/pet_advert_genders.dart';
import 'package:petjoo/modules/pet/model/pet_advert_types.dart';
import 'package:petjoo/modules/pet/viewmodel/pet_filter_viewmodel.dart';
import 'package:petjoo/product/constants/dimens.dart';

class PetFilterView extends StatelessWidget {
  final PetFilterViewModel vm = PetFilterViewModel();
  PetFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // queryText(),
            // const SizedBox(height: 20),
            DropdownX<int>(
              value: vm.type,
              hint: 'Kategori',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petAdvertTypes.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petAdvertTypes[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.type = value,
            ),
            const SizedBox(height: 20),
            DropdownX<int>(
              value: vm.delivery,
              hint: 'Tür',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petAdvertAnimals.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petAdvertAnimals[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.delivery = value,
            ),
            const SizedBox(height: 20),
            DropdownX<int>(
              value: vm.status,
              hint: 'Cinsiyet',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: petAdvertGenders.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(petAdvertGenders[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.status = value,
            ),
            const SizedBox(height: 20),
            buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => vm.resetFilter(),
            child: const Text('Sıfırla',
                style: TextStyle(color: Colors.redAccent)),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            onPressed: () => vm.setFilter(),
            child: const Text('Uygula'),
          ),
        )
      ],
    );
  }
}
