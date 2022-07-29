import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/enums/reservation/reservation_status.dart';
import 'package:petjoo/domain/repositories/transport_reservation_repository.dart';
import 'package:petjoo/infrastructure/model/transport_reservation_model.dart';
import 'package:table_calendar/table_calendar.dart';

class TransportReservationRequestListViewModel extends PageNotifier {
  TransportReservationRequestListViewModel(super.context, this._repository) {
    refreshReservations();
  }
  final TransportReservationRepository _repository;

  TransportReservationModelList reservationListt = [];

  late final scrollController = ScrollController()..addListener(_scrollListener);

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? mySelectedDay;

  TransportReservationModelList get reservationList => reservationListt.where((x) => isSameDay(x.date, mySelectedDay)).toList();

  void onFormatChanged(format) {
    if (calendarFormat != format) {
      calendarFormat = format;
      notifyListeners();
    }
  }

  void onDaySelected(selectedDay, focusedDay) {
    mySelectedDay = selectedDay;
    focusedDay = selectedDay;
    notifyListeners();
  }

  List<dynamic> eventLoader(day) {
    return reservationListt.where((e) => isSameDay(e.date, day)).toList();
  }

  Future<void> refreshReservations() async {
    reservationListt = await _repository.getReservationRequests();
    notifyListeners();
  }

  Future<void> getMoreReservations() async {
    reservationListt.addAll(await _repository.getReservationRequests(reservationListt.lastOrNull?.document));
    notifyListeners();
  }

  updateReservationStatus(TransportReservationModel reservation, ReservationStatus status) {
    _repository.updateReservationStatus(reservation.id!, status).then((value) {
      reservation.status = status;
      notifyListeners();
    }, onError: (e) => context.showSnackBar(context.localization.somethingWentWrong));
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      getMoreReservations();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
