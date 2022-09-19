// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_detail_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoreDetailViewModel on StoreDetailViewModelBase, Store {
  late final _$advertAtom =
      Atom(name: 'StoreDetailViewModelBase.advert', context: context);

  @override
  StoreAdvertModel? get advert {
    _$advertAtom.reportRead();
    return super.advert;
  }

  @override
  set advert(StoreAdvertModel? value) {
    _$advertAtom.reportWrite(value, super.advert, () {
      super.advert = value;
    });
  }

  late final _$userImageAtom =
      Atom(name: 'StoreDetailViewModelBase.userImage', context: context);

  @override
  String get userImage {
    _$userImageAtom.reportRead();
    return super.userImage;
  }

  @override
  set userImage(String value) {
    _$userImageAtom.reportWrite(value, super.userImage, () {
      super.userImage = value;
    });
  }

  late final _$userNameAtom =
      Atom(name: 'StoreDetailViewModelBase.userName', context: context);

  @override
  String? get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String? value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'StoreDetailViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$userInfoAsyncAction =
      AsyncAction('StoreDetailViewModelBase.userInfo', context: context);

  @override
  Future<dynamic> userInfo(String uid) {
    return _$userInfoAsyncAction.run(() => super.userInfo(uid));
  }

  late final _$publishAsyncAction =
      AsyncAction('StoreDetailViewModelBase.publish', context: context);

  @override
  Future<dynamic> publish(BuildContext context) {
    return _$publishAsyncAction.run(() => super.publish(context));
  }

  late final _$changeSoldAsyncAction =
      AsyncAction('StoreDetailViewModelBase.changeSold', context: context);

  @override
  Future<dynamic> changeSold(bool isSold, BuildContext _) {
    return _$changeSoldAsyncAction.run(() => super.changeSold(isSold, _));
  }

  late final _$deleteAsyncAction =
      AsyncAction('StoreDetailViewModelBase.delete', context: context);

  @override
  Future<dynamic> delete(BuildContext _) {
    return _$deleteAsyncAction.run(() => super.delete(_));
  }

  late final _$callAsyncAction =
      AsyncAction('StoreDetailViewModelBase.call', context: context);

  @override
  Future<dynamic> call() {
    return _$callAsyncAction.run(() => super.call());
  }

  late final _$messageAsyncAction =
      AsyncAction('StoreDetailViewModelBase.message', context: context);

  @override
  Future<dynamic> message(BuildContext _) {
    return _$messageAsyncAction.run(() => super.message(_));
  }

  late final _$StoreDetailViewModelBaseActionController =
      ActionController(name: 'StoreDetailViewModelBase', context: context);

  @override
  void setModel(StoreAdvertModel model) {
    final _$actionInfo = _$StoreDetailViewModelBaseActionController.startAction(
        name: 'StoreDetailViewModelBase.setModel');
    try {
      return super.setModel(model);
    } finally {
      _$StoreDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editModel(StoreAdvertModel model, BuildContext _) {
    final _$actionInfo = _$StoreDetailViewModelBaseActionController.startAction(
        name: 'StoreDetailViewModelBase.editModel');
    try {
      return super.editModel(model, _);
    } finally {
      _$StoreDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void error(BuildContext _, String data) {
    final _$actionInfo = _$StoreDetailViewModelBaseActionController.startAction(
        name: 'StoreDetailViewModelBase.error');
    try {
      return super.error(_, data);
    } finally {
      _$StoreDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$StoreDetailViewModelBaseActionController.startAction(
        name: 'StoreDetailViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$StoreDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
advert: ${advert},
userImage: ${userImage},
userName: ${userName},
isLoading: ${isLoading}
    ''';
  }
}
