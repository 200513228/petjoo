// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReservationListViewModel on ReservationListViewModelBase, Store {
  late final _$initDateAtom =
      Atom(name: 'ReservationListViewModelBase.initDate', context: context);

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

  late final _$reservationListAtom = Atom(
      name: 'ReservationListViewModelBase.reservationList', context: context);

  @override
  List<ReservationModel> get reservationList {
    _$reservationListAtom.reportRead();
    return super.reservationList;
  }

  @override
  set reservationList(List<ReservationModel> value) {
    _$reservationListAtom.reportWrite(value, super.reservationList, () {
      super.reservationList = value;
    });
  }

  late final _$getUserReservsAsyncAction = AsyncAction(
      'ReservationListViewModelBase.getUserReservs',
      context: context);

  @override
  Future<dynamic> getUserReservs() {
    return _$getUserReservsAsyncAction.run(() => super.getUserReservs());
  }

  late final _$getTransportReservsAsyncAction = AsyncAction(
      'ReservationListViewModelBase.getTransportReservs',
      context: context);

  @override
  Future<dynamic> getTransportReservs() {
    return _$getTransportReservsAsyncAction
        .run(() => super.getTransportReservs());
  }

  late final _$ReservationListViewModelBaseActionController =
      ActionController(name: 'ReservationListViewModelBase', context: context);

  @override
  void changeDate(DateTime d) {
    final _$actionInfo = _$ReservationListViewModelBaseActionController
        .startAction(name: 'ReservationListViewModelBase.changeDate');
    try {
      return super.changeDate(d);
    } finally {
      _$ReservationListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
initDate: ${initDate},
reservationList: ${reservationList}
    ''';
  }
}
