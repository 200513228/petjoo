// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_shift_tile_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransportShiftTileViewModel on TransportShiftTileViewModelBase, Store {
  late final _$startAtom =
      Atom(name: 'TransportShiftTileViewModelBase.start', context: context);

  @override
  String get start {
    _$startAtom.reportRead();
    return super.start;
  }

  @override
  set start(String value) {
    _$startAtom.reportWrite(value, super.start, () {
      super.start = value;
    });
  }

  late final _$endAtom =
      Atom(name: 'TransportShiftTileViewModelBase.end', context: context);

  @override
  String get end {
    _$endAtom.reportRead();
    return super.end;
  }

  @override
  set end(String value) {
    _$endAtom.reportWrite(value, super.end, () {
      super.end = value;
    });
  }

  late final _$isActiveAtom =
      Atom(name: 'TransportShiftTileViewModelBase.isActive', context: context);

  @override
  bool get isActive {
    _$isActiveAtom.reportRead();
    return super.isActive;
  }

  @override
  set isActive(bool value) {
    _$isActiveAtom.reportWrite(value, super.isActive, () {
      super.isActive = value;
    });
  }

  late final _$dayAtom =
      Atom(name: 'TransportShiftTileViewModelBase.day', context: context);

  @override
  int get day {
    _$dayAtom.reportRead();
    return super.day;
  }

  @override
  set day(int value) {
    _$dayAtom.reportWrite(value, super.day, () {
      super.day = value;
    });
  }

  late final _$TransportShiftTileViewModelBaseActionController =
      ActionController(
          name: 'TransportShiftTileViewModelBase', context: context);

  @override
  void activity() {
    final _$actionInfo = _$TransportShiftTileViewModelBaseActionController
        .startAction(name: 'TransportShiftTileViewModelBase.activity');
    try {
      return super.activity();
    } finally {
      _$TransportShiftTileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void starthourChange(String hour) {
    final _$actionInfo = _$TransportShiftTileViewModelBaseActionController
        .startAction(name: 'TransportShiftTileViewModelBase.starthourChange');
    try {
      return super.starthourChange(hour);
    } finally {
      _$TransportShiftTileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void endHourChange(String hour) {
    final _$actionInfo = _$TransportShiftTileViewModelBaseActionController
        .startAction(name: 'TransportShiftTileViewModelBase.endHourChange');
    try {
      return super.endHourChange(hour);
    } finally {
      _$TransportShiftTileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShift(TransportShiftModel model) {
    final _$actionInfo = _$TransportShiftTileViewModelBaseActionController
        .startAction(name: 'TransportShiftTileViewModelBase.setShift');
    try {
      return super.setShift(model);
    } finally {
      _$TransportShiftTileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
start: ${start},
end: ${end},
isActive: ${isActive},
day: ${day}
    ''';
  }
}
