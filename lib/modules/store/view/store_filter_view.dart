import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/modules/store/model/store_advert_deliveries.dart';
import 'package:petjoo/modules/store/model/store_advert_statuses.dart';
import 'package:petjoo/modules/store/model/store_adverts_types.dart';
import 'package:petjoo/modules/store/viewmodel/store_filter_viewmodel.dart';
import 'package:petjoo/product/constants/dimens.dart';

class StoreFilterView extends StatelessWidget {
  final StoreFilterViewModel vm = StoreFilterViewModel();
  StoreFilterView({Key? key}) : super(key: key);

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
              value: vm.type,
              hint: 'Kategori',
              label: 'Kategori',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: storeFilterTypes.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(storeFilterTypes[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.type = value,
            ),
            const SizedBox(height: 20),
            DropdownX<int>(
              value: vm.delivery,
              hint: 'Teslimat',
              label: 'Teslimat',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: storeFilterDeliveries.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(storeFilterDeliveries[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.delivery = value,
            ),
            const SizedBox(height: 20),
            DropdownX<int>(
              value: vm.status,
              hint: 'Durum',
              label: 'Durum',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: storeFilterStatuses.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(storeFilterStatuses[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.status = value,
            ),
            const SizedBox(height: 20),
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
