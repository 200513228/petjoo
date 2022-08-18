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
  String? get userImage {
    _$userImageAtom.reportRead();
    return super.userImage;
  }

  @override
  set userImage(String? value) {
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

  late final _$userInfoAsyncAction =
      AsyncAction('PetDetailViewModelBase.userInfo', context: context);

  @override
  Future<dynamic> userInfo(String uid) {
    return _$userInfoAsyncAction.run(() => super.userInfo(uid));
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
  void call() {
    final _$actionInfo = _$PetDetailViewModelBaseActionController.startAction(
        name: 'PetDetailViewModelBase.call');
    try {
      return super.call();
    } finally {
      _$PetDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
advert: ${advert},
userImage: ${userImage},
userName: ${userName}
    ''';
  }
}
