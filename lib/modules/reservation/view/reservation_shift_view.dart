import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/modules/reservation/viewmodel/reservation_shift_viewmodel.dart';
import 'package:petjoo/modules/transport/model/transport_advert_model.dart';

class ReservationShiftView extends StatelessWidget {
  final TransportAdvertModel model;
  final ReservationShiftViewModel vm = ReservationShiftViewModel();
  ReservationShiftView({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    vm.setShifts(model);
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          calendarAppBar(context),
          const Divider(color: Colors.black45),
          buildHourList(context),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget calendarAppBar(BuildContext context) {
    DateTime d = DateTime.now();
    vm.setHours(d.weekday - 1);
    return Observer(builder: (_) {
      return CalendarAppBar(
        position: 1,
        accent: colorPalette['primary'],
        white: colorPalette['secondary'],
        locale: context.locale.languageCode,
        onDateChanged: (value) => vm.changeDate(value),
        firstDate: d,
        fullCalendar: false,
        lastDate: DateTime(d.year, d.month, d.day + 6),
        selectedDate: vm.initDate,
      );
    });
  }

  Widget buildHourList(BuildContext context) {
    return Observer(builder: (_) {
      return vm.hours.isEmpty
          ? Center(
              child: Text(
                'Belirtilen tarihte hizmet verememekteyiz'.tr(),
                style: const TextStyle(color: Colors.black),
              ),
            )
          : Column(
              children: [...vm.hours.map((e) => hoursTile(context, e))],
            );
    });
  }

  Widget hoursTile(BuildContext context, String hour) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(colorPalette['secondary'])),
              onPressed: () => vm.pickHour(context, model, hour),
              child: Text(
                hour,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
