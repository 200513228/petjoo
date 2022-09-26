// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransportListViewModel on TransportListViewModelBase, Store {
  late final _$advertListAtom =
      Atom(name: 'TransportListViewModelBase.advertList', context: context);

  @override
  List<TransportAdvertModel> get advertList {
    _$advertListAtom.reportRead();
    return super.advertList;
  }

  @override
  set advertList(List<TransportAdvertModel> value) {
    _$advertListAtom.reportWrite(value, super.advertList, () {
      super.advertList = value;
    });
  }

  late final _$recoveryListAtom =
      Atom(name: 'TransportListViewModelBase.recoveryList', context: context);

  @override
  List<TransportAdvertModel> get recoveryList {
    _$recoveryListAtom.reportRead();
    return super.recoveryList;
  }

  @override
  set recoveryList(List<TransportAdvertModel> value) {
    _$recoveryListAtom.reportWrite(value, super.recoveryList, () {
      super.recoveryList = value;
    });
  }

  late final _$filterAtom =
      Atom(name: 'TransportListViewModelBase.filter', context: context);

  @override
  TransportFilterModel get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(TransportFilterModel value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  late final _$contAtom =
      Atom(name: 'TransportListViewModelBase.cont', context: context);

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

  late final _$getAdvertsAsyncAction =
      AsyncAction('TransportListViewModelBase.getAdverts', context: context);

  @override
  Future<dynamic> getAdverts() {
    return _$getAdvertsAsyncAction.run(() => super.getAdverts());
  }

  late final _$TransportListViewModelBaseActionController =
      ActionController(name: 'TransportListViewModelBase', context: context);

  @override
  void query(String query) {
    final _$actionInfo = _$TransportListViewModelBaseActionController
        .startAction(name: 'TransportListViewModelBase.query');
    try {
      return super.query(query);
    } finally {
      _$TransportListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFilter() {
    final _$actionInfo = _$TransportListViewModelBaseActionController
        .startAction(name: 'TransportListViewModelBase.resetFilter');
    try {
      return super.resetFilter();
    } finally {
      _$TransportListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(TransportFilterModel model) {
    final _$actionInfo = _$TransportListViewModelBaseActionController
        .startAction(name: 'TransportListViewModelBase.setFilter');
    try {
      return super.setFilter(model);
    } finally {
      _$TransportListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
advertList: ${advertList},
recoveryList: ${recoveryList},
filter: ${filter},
cont: ${cont}
    ''';
  }
}
