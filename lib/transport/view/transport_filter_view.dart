import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/num_extension.dart';
import 'package:petjoo/transport/model/transport_advert_intercities.dart';
import 'package:petjoo/transport/viewmodel/transport_filter_viewmodel.dart';
import 'package:petjoo/ui/dropdown_x.dart';
import 'package:petjoo/constants/dimens.dart';

class TransportFilterView extends StatelessWidget {
  final TransportFilterViewModel vm = TransportFilterViewModel();
  TransportFilterView({Key? key}) : super(key: key);

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
              value: vm.hasIntercity,
              hint: 'intercity'.tr(),
              label: 'intercity'.tr(),
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: transportFilterIntercities.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(transportFilterIntercities[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.hasIntercity = value,
            ),
            const SizedBox(height: 20),
            DropdownX<int>(
              value: vm.hasCage,
              hint: 'cage'.tr(),
              label: 'cage'.tr(),
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: transportFilterIntercities.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(transportFilterIntercities[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.hasCage = value,
            ),
            const SizedBox(height: 20),
            DropdownX<int>(
              value: vm.hasCollar,
              hint: 'collar'.tr(),
              label: 'collar'.tr(),
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: transportFilterIntercities.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(transportFilterIntercities[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.hasCollar = value,
            ),
            const SizedBox(height: 20),
            DropdownX<int>(
              value: vm.hasCatch,
              hint: 'catch'.tr(),
              label: 'catch'.tr(),
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: transportFilterIntercities.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(transportFilterIntercities[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.hasCatch = value,
            ),
            const SizedBox(height: 20),
            DropdownX<int>(
              value: vm.is24,
              hint: 'Acil',
              label: 'Acil',
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: transportFilterIntercities.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(transportFilterIntercities[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.is24 = value,
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
            child: Text('reset'.tr(),
                style: const TextStyle(color: Colors.redAccent)),
          ),
        ),
        const SizedBox(width: 20),
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
