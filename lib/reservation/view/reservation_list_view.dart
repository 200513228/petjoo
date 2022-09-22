import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/reservation/view/reservation_tile_view.dart';
import 'package:petjoo/reservation/viewmodel/reservation_list_viewmodel.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/ui/nothing_to_see_here_widget.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationListView extends StatelessWidget {
  final ReservationListViewModel vm = ReservationListViewModel();
  ReservationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CurrentUser.hasTransport ? vm.getTransportReservs() : vm.getUserReservs();
    return Observer(builder: (_) {
      return CurrentUser.hasTransport
          ? buildTransporterList(context)
          : buildUserList(context);
    });
  }

  Widget buildUserList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => vm.getUserReservs(),
      child: Column(
        children: [
          vm.reservationList.isEmpty
              ? const Expanded(child: NothingToSeeHereWidget())
              : Expanded(child: reservationList()),
        ],
      ),
    );
  }

  Widget buildTransporterList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => vm.getTransportReservs(),
      child: Column(
        children: [
          calendar(context),
          vm.reservationList.isEmpty
              ? const Expanded(child: NothingToSeeHereWidget())
              : Expanded(child: reservationList()),
        ],
      ),
    );
  }

  Widget calendar(BuildContext context) {
    DateTime d = DateTime.now();
    return Container(
      color: colorPalette['secondary'],
      child: Observer(builder: (_) {
        return TableCalendar(
          locale: context.locale.languageCode,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarFormat: CalendarFormat.twoWeeks,
          focusedDay: vm.initDate,
          currentDay: vm.initDate,
          firstDay: DateTime(2020, 1, 1),
          lastDay: DateTime(d.year, d.month, d.day + 7),
          onDaySelected: (date, date2) {
            vm.changeDate(date);
          },
          availableCalendarFormats: const {CalendarFormat.twoWeeks: '2 weeks'},
        );
      }),
    );
  }

  Widget reservationList() {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        ...vm.reservationList.map((e) => ReservationTileView(
              model: e,
              isUser: !CurrentUser.hasTransport,
            ))
      ],
    );
  }
}
