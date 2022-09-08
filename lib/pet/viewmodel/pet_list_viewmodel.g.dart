// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetListViewModel on PetListViewModelBase, Store {
  late final _$advertListAtom =
      Atom(name: 'PetListViewModelBase.advertList', context: context);

  @override
  List<PetAdvertModel> get advertList {
    _$advertListAtom.reportRead();
    return super.advertList;
  }

  @override
  set advertList(List<PetAdvertModel> value) {
    _$advertListAtom.reportWrite(value, super.advertList, () {
      super.advertList = value;
    });
  }

  late final _$recoveryListAtom =
      Atom(name: 'PetListViewModelBase.recoveryList', context: context);

  @override
  List<PetAdvertModel> get recoveryList {
    _$recoveryListAtom.reportRead();
    return super.recoveryList;
  }

  @override
  set recoveryList(List<PetAdvertModel> value) {
    _$recoveryListAtom.reportWrite(value, super.recoveryList, () {
      super.recoveryList = value;
    });
  }

  late final _$filterAtom =
      Atom(name: 'PetListViewModelBase.filter', context: context);

  @override
  PetFilterModel get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(PetFilterModel value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  late final _$contAtom =
      Atom(name: 'PetListViewModelBase.cont', context: context);

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
      AsyncAction('PetListViewModelBase.getAdverts', context: context);

  @override
  Future<dynamic> getAdverts() {
    return _$getAdvertsAsyncAction.run(() => super.getAdverts());
  }

  late final _$PetListViewModelBaseActionController =
      ActionController(name: 'PetListViewModelBase', context: context);

  @override
  void query(String query) {
    final _$actionInfo = _$PetListViewModelBaseActionController.startAction(
        name: 'PetListViewModelBase.query');
    try {
      return super.query(query);
    } finally {
      _$PetListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFilter() {
    final _$actionInfo = _$PetListViewModelBaseActionController.startAction(
        name: 'PetListViewModelBase.resetFilter');
    try {
      return super.resetFilter();
    } finally {
      _$PetListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(PetFilterModel model) {
    final _$actionInfo = _$PetListViewModelBaseActionController.startAction(
        name: 'PetListViewModelBase.setFilter');
    try {
      return super.setFilter(model);
    } finally {
      _$PetListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pickAdvert(PetAdvertModel model, BuildContext _) {
    final _$actionInfo = _$PetListViewModelBaseActionController.startAction(
        name: 'PetListViewModelBase.pickAdvert');
    try {
      return super.pickAdvert(model, _);
    } finally {
      _$PetListViewModelBaseActionController.endAction(_$actionInfo);
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
