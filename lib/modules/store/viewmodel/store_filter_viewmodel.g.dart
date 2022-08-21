// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_filter_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoreFilterViewModel on StoreFilterViewModelBase, Store {
  late final _$contAtom =
      Atom(name: 'StoreFilterViewModelBase.cont', context: context);

  @override
  TextEditingController get cont {
    _$contAtom.reportRead();
    return super.cont;
  }

  @override
  set cont(TextEditingController value) {
    _$contAtom.reportWrite(value, super.cont, () {
      super.cont = value;
    });
  }

  late final _$typeAtom =
      Atom(name: 'StoreFilterViewModelBase.type', context: context);

  @override
  int? get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(int? value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  late final _$deliveryAtom =
      Atom(name: 'StoreFilterViewModelBase.delivery', context: context);

  @override
  int? get delivery {
    _$deliveryAtom.reportRead();
    return super.delivery;
  }

  @override
  set delivery(int? value) {
    _$deliveryAtom.reportWrite(value, super.delivery, () {
      super.delivery = value;
    });
  }

  late final _$statusAtom =
      Atom(name: 'StoreFilterViewModelBase.status', context: context);

  @override
  int? get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(int? value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$StoreFilterViewModelBaseActionController =
      ActionController(name: 'StoreFilterViewModelBase', context: context);

  @override
  void resetFilter() {
    final _$actionInfo = _$StoreFilterViewModelBaseActionController.startAction(
        name: 'StoreFilterViewModelBase.resetFilter');
    try {
      return super.resetFilter();
    } finally {
      _$StoreFilterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter() {
    final _$actionInfo = _$StoreFilterViewModelBaseActionController.startAction(
        name: 'StoreFilterViewModelBase.setFilter');
    try {
      return super.setFilter();
    } finally {
      _$StoreFilterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cont: ${cont},
type: ${type},
delivery: ${delivery},
status: ${status}
    ''';
  }
}
