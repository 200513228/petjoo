import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/transport/view/transport_shift_tile_view.dart';
import 'package:petjoo/transport/viewmodel/transport_hours_viewmodel.dart';

class TransportHoursView extends StatelessWidget {
  final TransportHoursViewModel vm = TransportHoursViewModel();
  final List shiftList;
  TransportHoursView({required this.shiftList, super.key});

  @override
  Widget build(BuildContext context) {
    vm.setShifts(shiftList);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: Text('edit_working_hours'.tr()),
          centerTitle: true,
        ),
        body: Observer(builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ...vm.shiftList.map((e) => TransportShiftTileView(model: e)),
                saveHoursButton(context),
              ],
            ),
          );
        }));
  }

  Widget saveHoursButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: () => vm.saveHours(context),
              child: Text('save'.tr()),
            ),
          ),
        )
      ],
    );
  }
}
