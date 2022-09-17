import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/reservation/view/reservation_tile_view.dart';
import 'package:petjoo/reservation/viewmodel/reservation_list_viewmodel.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationListView extends StatelessWidget {
  final ReservationListViewModel vm = ReservationListViewModel();
  ReservationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // vm.getReservations();
    // return Observer(builder: (_) {
    //   return RefreshIndicator(
    //     onRefresh: () => vm.getReservations(),
    //     child: Column(
    //       children: [
    //         calendar(context),
    //         vm.reservationList.isEmpty
    //             ? const Expanded(child: NothingToSeeHereWidget())
    //             : Expanded(child: reservationList()),
    //       ],
    //     ),
    //   );
    // });
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.construction,
            color: Colors.black,
            size: 64,
          ),
          const Divider(),
          Text('under_maintenance'.tr(),
              style: const TextStyle(color: Colors.black, fontSize: 24)),
          Text('under_maintenance_content'.tr(),
              style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Widget calendar(BuildContext context) {
    DateTime d = DateTime.now();
    return Container(
      color: colorPalette['secondary'],
      child: TableCalendar(
        locale: context.locale.languageCode,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarFormat: CalendarFormat.twoWeeks,
        focusedDay: d,
        firstDay: DateTime.now(),
        lastDay: DateTime(d.year, d.month, d.day + 7),
        onDaySelected: (date, date2) {
          log('DATE1$date');
          log('DATE2$date2');
        },
        availableCalendarFormats: const {CalendarFormat.twoWeeks: '2 weeks'},
      ),
    );
  }

  Widget reservationList() {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        ...vm.reservationList.map((e) => ReservationTileView(model: e))
      ],
    );
  }
}
