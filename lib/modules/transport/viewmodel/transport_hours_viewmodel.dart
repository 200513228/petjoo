import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/transport/model/transport_shift_model.dart';

part 'transport_hours_viewmodel.g.dart';

class TransportHoursViewModel = TransportHoursViewModelBase
    with _$TransportHoursViewModel;

abstract class TransportHoursViewModelBase with Store {
  @observable
  List<TransportShiftModel> shiftList = [];

  @action
  void setShifts(List shifts) {
    List<TransportShiftModel> temp = [];
    for (var element in shifts) {
      temp.add(TransportShiftModel.fromMap(element as Map));
    }
    shiftList = temp;
  }

  @action
  void saveHours(BuildContext context) {
    Navigator.pop(context);
  }
}
