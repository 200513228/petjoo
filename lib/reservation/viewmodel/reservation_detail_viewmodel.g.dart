// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_detail_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReservationDetailViewModel on ReservationDetailViewModelBase, Store {
  late final _$modelAtom =
      Atom(name: 'ReservationDetailViewModelBase.model', context: context);

  @override
  ReservationModel? get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(ReservationModel? value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  late final _$userImageAtom =
      Atom(name: 'ReservationDetailViewModelBase.userImage', context: context);

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
      Atom(name: 'ReservationDetailViewModelBase.userName', context: context);

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

  late final _$companyPhoneAtom = Atom(
      name: 'ReservationDetailViewModelBase.companyPhone', context: context);

  @override
  String? get companyPhone {
    _$companyPhoneAtom.reportRead();
    return super.companyPhone;
  }

  @override
  set companyPhone(String? value) {
    _$companyPhoneAtom.reportWrite(value, super.companyPhone, () {
      super.companyPhone = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ReservationDetailViewModelBase.isLoading', context: context);

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
      AsyncAction('ReservationDetailViewModelBase.userInfo', context: context);

  @override
  Future<dynamic> userInfo(String uid) {
    return _$userInfoAsyncAction.run(() => super.userInfo(uid));
  }

  late final _$callAsyncAction =
      AsyncAction('ReservationDetailViewModelBase.call', context: context);

  @override
  Future<dynamic> call() {
    return _$callAsyncAction.run(() => super.call());
  }

  late final _$messageAsyncAction =
      AsyncAction('ReservationDetailViewModelBase.message', context: context);

  @override
  Future<dynamic> message(BuildContext _) {
    return _$messageAsyncAction.run(() => super.message(_));
  }

  late final _$updateResAsyncAction =
      AsyncAction('ReservationDetailViewModelBase.updateRes', context: context);

  @override
  Future<dynamic> updateRes(BuildContext _, int status) {
    return _$updateResAsyncAction.run(() => super.updateRes(_, status));
  }

  late final _$ReservationDetailViewModelBaseActionController =
      ActionController(
          name: 'ReservationDetailViewModelBase', context: context);

  @override
  void setModels(ReservationModel xmodel) {
    final _$actionInfo = _$ReservationDetailViewModelBaseActionController
        .startAction(name: 'ReservationDetailViewModelBase.setModels');
    try {
      return super.setModels(xmodel);
    } finally {
      _$ReservationDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void error(BuildContext _, String data) {
    final _$actionInfo = _$ReservationDetailViewModelBaseActionController
        .startAction(name: 'ReservationDetailViewModelBase.error');
    try {
      return super.error(_, data);
    } finally {
      _$ReservationDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$ReservationDetailViewModelBaseActionController
        .startAction(name: 'ReservationDetailViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$ReservationDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
model: ${model},
userImage: ${userImage},
userName: ${userName},
companyPhone: ${companyPhone},
isLoading: ${isLoading}
    ''';
  }
}
