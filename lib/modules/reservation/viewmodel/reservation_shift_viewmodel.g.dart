// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_shift_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReservationShiftViewModel on ReservationShiftViewModelBase, Store {
  late final _$shiftsAtom =
      Atom(name: 'ReservationShiftViewModelBase.shifts', context: context);

  @override
  List<TransportShiftModel> get shifts {
    _$shiftsAtom.reportRead();
    return super.shifts;
  }

  @override
  set shifts(List<TransportShiftModel> value) {
    _$shiftsAtom.reportWrite(value, super.shifts, () {
      super.shifts = value;
    });
  }

  late final _$hoursAtom =
      Atom(name: 'ReservationShiftViewModelBase.hours', context: context);

  @override
  List<String> get hours {
    _$hoursAtom.reportRead();
    return super.hours;
  }

  @override
  set hours(List<String> value) {
    _$hoursAtom.reportWrite(value, super.hours, () {
      super.hours = value;
    });
  }

  late final _$initDateAtom =
      Atom(name: 'ReservationShiftViewModelBase.initDate', context: context);

  @override
  DateTime get initDate {
    _$initDateAtom.reportRead();
    return super.initDate;
  }

  @override
  set initDate(DateTime value) {
    _$initDateAtom.reportWrite(value, super.initDate, () {
      super.initDate = value;
    });
  }

  late final _$ReservationShiftViewModelBaseActionController =
      ActionController(name: 'ReservationShiftViewModelBase', context: context);

  @override
  void changeDate(DateTime date) {
    final _$actionInfo = _$ReservationShiftViewModelBaseActionController
        .startAction(name: 'ReservationShiftViewModelBase.changeDate');
    try {
      return super.changeDate(date);
    } finally {
      _$ReservationShiftViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShifts(TransportAdvertModel model) {
    final _$actionInfo = _$ReservationShiftViewModelBaseActionController
        .startAction(name: 'ReservationShiftViewModelBase.setShifts');
    try {
      return super.setShifts(model);
    } finally {
      _$ReservationShiftViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pickHour(TransportAdvertModel model) {
    final _$actionInfo = _$ReservationShiftViewModelBaseActionController
        .startAction(name: 'ReservationShiftViewModelBase.pickHour');
    try {
      return super.pickHour(model);
    } finally {
      _$ReservationShiftViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
shifts: ${shifts},
hours: ${hours},
initDate: ${initDate}
    ''';
  }
}
