import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/modules/base/dropdown_x.dart';
import 'package:petjoo/modules/base/color_palette.dart';
import 'package:petjoo/modules/base/string_converters.dart';
import 'package:petjoo/modules/transport/model/transport_shift_hours.dart';
import 'package:petjoo/modules/transport/model/transport_shift_model.dart';
import 'package:petjoo/modules/transport/viewmodel/transport_shift_tile_viewmodel.dart';
import 'package:petjoo/product/constants/dimens.dart';

class TransportShiftTileView extends StatelessWidget {
  final TransportShiftModel model;
  final TransportShiftTileViewModel vm = TransportShiftTileViewModel();
  TransportShiftTileView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setShift(model);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: colorPalette['secondary']),
      child: SingleChildScrollView(
        child: Observer(builder: (_) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            dayToString(vm.day),
                            style: const TextStyle(fontSize: 16),
                          )),
                    ),
                  ),
                  Switch(
                      overlayColor: MaterialStateProperty.all(Colors.black),
                      value: vm.isActive,
                      onChanged: (value) => vm.activity())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: DropdownX<String>(
                      color: Colors.black,
                      value: vm.start,
                      hint: 'start'.tr(),
                      label: 'start'.tr(),
                      borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
                      items: TransportThings.transportShiftHours
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) => vm.starthourChange(value!),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: DropdownX<String>(
                      value: vm.end,
                      color: Colors.black,
                      hint: 'end'.tr(),
                      label: 'end'.tr(),
                      borderRadius: Dimens.radiusSmall.toRightBorderRadius(),
                      items: TransportThings.transportShiftHours
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) => vm.endHourChange(value!),
                    ),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
