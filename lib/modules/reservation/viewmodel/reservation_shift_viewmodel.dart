import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/base/string_converters.dart';
import 'package:petjoo/modules/transport/model/transport_advert_model.dart';
import 'package:petjoo/modules/transport/model/transport_shift_model.dart';
part 'reservation_shift_viewmodel.g.dart';

class ReservationShiftViewModel = ReservationShiftViewModelBase
    with _$ReservationShiftViewModel;

abstract class ReservationShiftViewModelBase with Store {
  @observable
  List<TransportShiftModel> shifts = [];
  @observable
  List<String> hours = [];
  @observable
  DateTime initDate = DateTime.now();

  @action
  void changeDate(DateTime date) {
    initDate = date;
    setHours(initDate.weekday - 1);
  }

  void setHours(int day) {
    List<String> temp = [];
    TransportShiftModel x = shifts[day];
    int startHour = int.parse(x.start.split(':')[0]);
    int startMinute = int.parse(x.start.split(':')[1]);
    int endHour = int.parse(x.end.split(':')[0]);
    int forCount = endHour - startHour < 0
        ? endHour - startHour + 24
        : endHour - startHour;
    if (shifts[day].isActive) {
      for (var i = 0; i < forCount; i++) {
        temp.add(hourToString('${startHour + i}:$startMinute'));
      }
    }
    hours = temp;
  }

  @action
  void setShifts(TransportAdvertModel model) {
    List<TransportShiftModel> temp = [];
    for (var element in model.shifts) {
      temp.add(TransportShiftModel.fromMap(element));
    }
    shifts = temp;
  }

  @action
  void pickHour(TransportAdvertModel model) {}
}
