// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_userlist_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetUserListViewModel on PetUserListViewModelBase, Store {
  late final _$advertListAtom =
      Atom(name: 'PetUserListViewModelBase.advertList', context: context);

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

  late final _$getAdvertsAsyncAction =
      AsyncAction('PetUserListViewModelBase.getAdverts', context: context);

  @override
  Future<dynamic> getAdverts() {
    return _$getAdvertsAsyncAction.run(() => super.getAdverts());
  }

  late final _$PetUserListViewModelBaseActionController =
      ActionController(name: 'PetUserListViewModelBase', context: context);

  @override
  void selectAdvert() {
    final _$actionInfo = _$PetUserListViewModelBaseActionController.startAction(
        name: 'PetUserListViewModelBase.selectAdvert');
    try {
      return super.selectAdvert();
    } finally {
      _$PetUserListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void newAdvert(BuildContext _) {
    final _$actionInfo = _$PetUserListViewModelBaseActionController.startAction(
        name: 'PetUserListViewModelBase.newAdvert');
    try {
      return super.newAdvert(_);
    } finally {
      _$PetUserListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
advertList: ${advertList}
    ''';
  }
}
