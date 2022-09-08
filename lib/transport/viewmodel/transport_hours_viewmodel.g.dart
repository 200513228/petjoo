// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_hours_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransportHoursViewModel on TransportHoursViewModelBase, Store {
  late final _$shiftListAtom =
      Atom(name: 'TransportHoursViewModelBase.shiftList', context: context);

  @override
  List<TransportShiftModel> get shiftList {
    _$shiftListAtom.reportRead();
    return super.shiftList;
  }

  @override
  set shiftList(List<TransportShiftModel> value) {
    _$shiftListAtom.reportWrite(value, super.shiftList, () {
      super.shiftList = value;
    });
  }

  late final _$TransportHoursViewModelBaseActionController =
      ActionController(name: 'TransportHoursViewModelBase', context: context);

  @override
  void setShifts(List<dynamic> shifts) {
    final _$actionInfo = _$TransportHoursViewModelBaseActionController
        .startAction(name: 'TransportHoursViewModelBase.setShifts');
    try {
      return super.setShifts(shifts);
    } finally {
      _$TransportHoursViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveHours(BuildContext context) {
    final _$actionInfo = _$TransportHoursViewModelBaseActionController
        .startAction(name: 'TransportHoursViewModelBase.saveHours');
    try {
      return super.saveHours(context);
    } finally {
      _$TransportHoursViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
shiftList: ${shiftList}
    ''';
  }
}
