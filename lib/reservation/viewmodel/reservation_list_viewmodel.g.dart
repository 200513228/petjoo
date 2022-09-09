// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReservationListViewModel on ReservationListViewModelBase, Store {
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

  late final _$getReservationsAsyncAction = AsyncAction(
      'ReservationListViewModelBase.getReservations',
      context: context);

  @override
  Future<dynamic> getReservations() {
    return _$getReservationsAsyncAction.run(() => super.getReservations());
  }

  @override
  String toString() {
    return '''
reservationList: ${reservationList}
    ''';
  }
}
