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
    CurrentUser.hasTransport ? vm.getEvents() : null;
    return Observer(builder: (_) {
      return CurrentUser.hasTransport
          ? transporterPageView(_)
          : buildUserList(_);
    });
  }

  Widget transporterPageView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: vm.pc,
            onPageChanged: (value) {
              switch (value) {
                case 0:
                  vm.getTransportReservs();
                  break;
                case 1:
                  vm.getEmergancyReservs();
                  break;
                case 2:
                  vm.getUserReservs();
                  break;
                default:
              }
            },
            children: [
              buildTransporterList(context),
              buildEmergancyList(context),
              buildUserList(context),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 6,
              child: MaterialButton(
                  color: colorPalette['secondary'],
                  onPressed: () {
                    vm.reservationList.clear();
                    vm.pc.jumpToPage(0);
                    // vm.pc.animateToPage(0,
                    //     duration: const Duration(milliseconds: 100),
                    //     curve: Curves.bounceOut);
                  },
                  child: Text('company'.tr(),
                      style: const TextStyle(color: Colors.white)))),
          Expanded(flex: 3, child: Container()),
          Expanded(
              flex: 6,
              child: MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    vm.reservationList.clear();
                    vm.pc.jumpToPage(1);
                    // vm.pc.animateToPage(0,
                    //     duration: const Duration(milliseconds: 100),
                    //     curve: Curves.bounceOut);
                  },
                  child: Text('Acil'.tr(),
                      style: const TextStyle(color: Colors.white)))),
          Expanded(flex: 3, child: Container()),
          Expanded(
              flex: 6,
              child: MaterialButton(
                  color: colorPalette['secondary'],
                  onPressed: () {
                    vm.reservationList.clear();
                    vm.pc.jumpToPage(2);
                    // vm.pc.animateToPage(1,
                    //     duration: const Duration(milliseconds: 100),
                    //     curve: Curves.decelerate);
                  },
                  child: Text('other'.tr(),
                      maxLines: 1,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: const TextStyle(color: Colors.white)))),
          Expanded(flex: 1, child: Container()),
        ]),
      ],
    );
  }

  Widget buildUserList(BuildContext context) {
    // vm.getUserReservs();
    return RefreshIndicator(
      color: Colors.black,
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

  Widget buildEmergancyList(BuildContext context) {
    return RefreshIndicator(
      color: Colors.black,
      onRefresh: () => vm.getEmergancyReservs(),
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
      color: Colors.black,
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
          calendarStyle: CalendarStyle(
              markersMaxCount: 1,
              markerDecoration: BoxDecoration(
                  color: colorPalette['primary'], shape: BoxShape.circle)),
          availableCalendarFormats: const {CalendarFormat.twoWeeks: '2 weeks'},
          focusedDay: vm.initDate,
          currentDay: vm.initDate,
          weekendDays: const [],
          firstDay: DateTime(2020, 1, 1),
          lastDay: DateTime(d.year, d.month, d.day + 30),
          onDaySelected: (date, date2) {
            vm.changeDate(date);
          },
          eventLoader: (day) {
            return vm.events['${day.month}.${day.day}'] ?? [];
          },
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
              isUser: CurrentUser.id != e.advertId,
            ))
      ],
    );
  }
}
