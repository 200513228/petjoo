// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_detail_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetDetailViewModel on PetDetailViewModelBase, Store {
  late final _$advertAtom =
      Atom(name: 'PetDetailViewModelBase.advert', context: context);

  @override
  PetAdvertModel? get advert {
    _$advertAtom.reportRead();
    return super.advert;
  }

  @override
  set advert(PetAdvertModel? value) {
    _$advertAtom.reportWrite(value, super.advert, () {
      super.advert = value;
    });
  }

  late final _$userImageAtom =
      Atom(name: 'PetDetailViewModelBase.userImage', context: context);

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
      Atom(name: 'PetDetailViewModelBase.userName', context: context);

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
      Atom(name: 'PetDetailViewModelBase.isLoading', context: context);

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
      AsyncAction('PetDetailViewModelBase.userInfo', context: context);

  @override
  Future<dynamic> userInfo(String uid) {
    return _$userInfoAsyncAction.run(() => super.userInfo(uid));
  }

  late final _$publishAsyncAction =
      AsyncAction('PetDetailViewModelBase.publish', context: context);

  @override
  Future<dynamic> publish(BuildContext context) {
    return _$publishAsyncAction.run(() => super.publish(context));
  }

  late final _$changeAdoptAsyncAction =
      AsyncAction('PetDetailViewModelBase.changeAdopt', context: context);

  @override
  Future<dynamic> changeAdopt(bool isAdopt, BuildContext _) {
    return _$changeAdoptAsyncAction.run(() => super.changeAdopt(isAdopt, _));
  }

  late final _$deleteAsyncAction =
      AsyncAction('PetDetailViewModelBase.delete', context: context);

  @override
  Future<dynamic> delete(BuildContext _) {
    return _$deleteAsyncAction.run(() => super.delete(_));
  }

  late final _$callAsyncAction =
      AsyncAction('PetDetailViewModelBase.call', context: context);

  @override
  Future<dynamic> call() {
    return _$callAsyncAction.run(() => super.call());
  }

  late final _$messageAsyncAction =
      AsyncAction('PetDetailViewModelBase.message', context: context);

  @override
  Future<dynamic> message(BuildContext _) {
    return _$messageAsyncAction.run(() => super.message(_));
  }

  late final _$PetDetailViewModelBaseActionController =
      ActionController(name: 'PetDetailViewModelBase', context: context);

  @override
  void setModel(PetAdvertModel model) {
    final _$actionInfo = _$PetDetailViewModelBaseActionController.startAction(
        name: 'PetDetailViewModelBase.setModel');
    try {
      return super.setModel(model);
    } finally {
      _$PetDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editModel(PetAdvertModel model, BuildContext _) {
    final _$actionInfo = _$PetDetailViewModelBaseActionController.startAction(
        name: 'PetDetailViewModelBase.editModel');
    try {
      return super.editModel(model, _);
    } finally {
      _$PetDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void error(BuildContext _, String data) {
    final _$actionInfo = _$PetDetailViewModelBaseActionController.startAction(
        name: 'PetDetailViewModelBase.error');
    try {
      return super.error(_, data);
    } finally {
      _$PetDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$PetDetailViewModelBaseActionController.startAction(
        name: 'PetDetailViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$PetDetailViewModelBaseActionController.endAction(_$actionInfo);
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
