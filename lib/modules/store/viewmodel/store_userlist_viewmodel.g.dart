// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_userlist_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoreUserListViewModel on StoreUserListViewModelBase, Store {
  late final _$advertListAtom =
      Atom(name: 'StoreUserListViewModelBase.advertList', context: context);

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

  late final _$getUserAdvertsAsyncAction = AsyncAction(
      'StoreUserListViewModelBase.getUserAdverts',
      context: context);

  @override
  Future<dynamic> getUserAdverts() {
    return _$getUserAdvertsAsyncAction.run(() => super.getUserAdverts());
  }

  late final _$newAdvertAsyncAction =
      AsyncAction('StoreUserListViewModelBase.newAdvert', context: context);

  @override
  Future<dynamic> newAdvert(BuildContext _) {
    return _$newAdvertAsyncAction.run(() => super.newAdvert(_));
  }

  late final _$openAdvertAsyncAction =
      AsyncAction('StoreUserListViewModelBase.openAdvert', context: context);

  @override
  Future<dynamic> openAdvert(BuildContext _, StoreAdvertModel model) {
    return _$openAdvertAsyncAction.run(() => super.openAdvert(_, model));
  }

  @override
  String toString() {
    return '''
advertList: ${advertList}
    ''';
  }
}
