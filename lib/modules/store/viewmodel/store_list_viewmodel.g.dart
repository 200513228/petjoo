// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoreListViewModel on StoreListViewModelBase, Store {
  late final _$advertListAtom =
      Atom(name: 'StoreListViewModelBase.advertList', context: context);

  @override
  List<StoreAdvertModel> get advertList {
    _$advertListAtom.reportRead();
    return super.advertList;
  }

  @override
  set advertList(List<StoreAdvertModel> value) {
    _$advertListAtom.reportWrite(value, super.advertList, () {
      super.advertList = value;
    });
  }

  late final _$getAdvertsAsyncAction =
      AsyncAction('StoreListViewModelBase.getAdverts', context: context);

  @override
  Future<dynamic> getAdverts() {
    return _$getAdvertsAsyncAction.run(() => super.getAdverts());
  }

  late final _$StoreListViewModelBaseActionController =
      ActionController(name: 'StoreListViewModelBase', context: context);

  @override
  void pickAdvert(StoreAdvertModel model, BuildContext _) {
    final _$actionInfo = _$StoreListViewModelBaseActionController.startAction(
        name: 'StoreListViewModelBase.pickAdvert');
    try {
      return super.pickAdvert(model, _);
    } finally {
      _$StoreListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
advertList: ${advertList}
    ''';
  }
}
