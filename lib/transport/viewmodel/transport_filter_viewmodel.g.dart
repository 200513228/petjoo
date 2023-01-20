// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_filter_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransportFilterViewModel on TransportFilterViewModelBase, Store {
  late final _$hasIntercityAtom =
      Atom(name: 'TransportFilterViewModelBase.hasIntercity', context: context);

  @override
  int? get hasIntercity {
    _$hasIntercityAtom.reportRead();
    return super.hasIntercity;
  }

  @override
  set hasIntercity(int? value) {
    _$hasIntercityAtom.reportWrite(value, super.hasIntercity, () {
      super.hasIntercity = value;
    });
  }

  late final _$hasCageAtom =
      Atom(name: 'TransportFilterViewModelBase.hasCage', context: context);

  @override
  int? get hasCage {
    _$hasCageAtom.reportRead();
    return super.hasCage;
  }

  @override
  set hasCage(int? value) {
    _$hasCageAtom.reportWrite(value, super.hasCage, () {
      super.hasCage = value;
    });
  }

  late final _$hasCollarAtom =
      Atom(name: 'TransportFilterViewModelBase.hasCollar', context: context);

  @override
  int? get hasCollar {
    _$hasCollarAtom.reportRead();
    return super.hasCollar;
  }

  @override
  set hasCollar(int? value) {
    _$hasCollarAtom.reportWrite(value, super.hasCollar, () {
      super.hasCollar = value;
    });
  }

  late final _$hasCatchAtom =
      Atom(name: 'TransportFilterViewModelBase.hasCatch', context: context);

  @override
  int? get hasCatch {
    _$hasCatchAtom.reportRead();
    return super.hasCatch;
  }

  @override
  set hasCatch(int? value) {
    _$hasCatchAtom.reportWrite(value, super.hasCatch, () {
      super.hasCatch = value;
    });
  }

  late final _$is24Atom =
      Atom(name: 'TransportFilterViewModelBase.is24', context: context);

  @override
  int? get is24 {
    _$is24Atom.reportRead();
    return super.is24;
  }

  @override
  set is24(int? value) {
    _$is24Atom.reportWrite(value, super.is24, () {
      super.is24 = value;
    });
  }

  late final _$TransportFilterViewModelBaseActionController =
      ActionController(name: 'TransportFilterViewModelBase', context: context);

  @override
  void resetFilter(BuildContext context) {
    final _$actionInfo = _$TransportFilterViewModelBaseActionController
        .startAction(name: 'TransportFilterViewModelBase.resetFilter');
    try {
      return super.resetFilter(context);
    } finally {
      _$TransportFilterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(BuildContext context) {
    final _$actionInfo = _$TransportFilterViewModelBaseActionController
        .startAction(name: 'TransportFilterViewModelBase.setFilter');
    try {
      return super.setFilter(context);
    } finally {
      _$TransportFilterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrent() {
    final _$actionInfo = _$TransportFilterViewModelBaseActionController
        .startAction(name: 'TransportFilterViewModelBase.setCurrent');
    try {
      return super.setCurrent();
    } finally {
      _$TransportFilterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hasIntercity: ${hasIntercity},
hasCage: ${hasCage},
hasCollar: ${hasCollar},
hasCatch: ${hasCatch},
is24: ${is24}
    ''';
  }
}
