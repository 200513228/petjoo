import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/reservation/service/reservation_service.dart';
part 'reservation_list_viewmodel.g.dart';

class ReservationListViewModel = ReservationListViewModelBase
    with _$ReservationListViewModel;

abstract class ReservationListViewModelBase with Store {
  @observable
  DateTime initDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 3);
  @observable
  List<ReservationModel> reservationList = [];
  @observable
  Map<String, List?> events = {};
  @observable
  PageController pc = PageController(initialPage: 0);

  @action
  Future getUserReservs() async {
    List<ReservationModel> temp = [];
    var data = await ReservationService.getReservations(Timestamp.now(), false);
    for (var element in data.docs) {
      temp.add(ReservationModel.fromQDS(element));
      temp.sort((b, a) => a.date.millisecondsSinceEpoch
          .compareTo(b.date.millisecondsSinceEpoch));
    }
    reservationList = temp;
  }

  @action
  Future getEvents() async {
    DateTime d = DateTime.now();
    for (var i = 0; i < 7; i++) {
      var data = await ReservationService.getWeekCounter(
          DateTime(d.year, d.month, d.day + i));
      events['${d.month}.${d.day + i}'] = data;
    }
    initDate = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
  }

  @action
  Future getTransportReservs() async {
    List<ReservationModel> temp = [];
    var data = await ReservationService.getReservations(
        Timestamp.fromDate(initDate.subtract(const Duration(hours: 3))), true);
    for (var element in data.docs) {
      temp.add(ReservationModel.fromQDS(element));
      temp.sort((b, a) => a.date.millisecondsSinceEpoch
          .compareTo(b.date.millisecondsSinceEpoch));
    }
    reservationList = temp;
  }

  @action
  void changeDate(DateTime d) {
    initDate = d;
    getTransportReservs();
  }
}
