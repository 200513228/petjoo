// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_tile_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReservationTileViewModel on ReservationTileViewModelBase, Store {
  late final _$modelAtom =
      Atom(name: 'ReservationTileViewModelBase.model', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: 'ReservationTileViewModelBase.isLoading', context: context);

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

  late final _$userImageAtom =
      Atom(name: 'ReservationTileViewModelBase.userImage', context: context);

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
      Atom(name: 'ReservationTileViewModelBase.userName', context: context);

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

  late final _$callAsyncAction =
      AsyncAction('ReservationTileViewModelBase.call', context: context);

  @override
  Future<dynamic> call() {
    return _$callAsyncAction.run(() => super.call());
  }

  late final _$messageAsyncAction =
      AsyncAction('ReservationTileViewModelBase.message', context: context);

  @override
  Future<dynamic> message(BuildContext _) {
    return _$messageAsyncAction.run(() => super.message(_));
  }

  late final _$userInfoAsyncAction =
      AsyncAction('ReservationTileViewModelBase.userInfo', context: context);

  @override
  Future<dynamic> userInfo(bool isUser) {
    return _$userInfoAsyncAction.run(() => super.userInfo(isUser));
  }

  late final _$ReservationTileViewModelBaseActionController =
      ActionController(name: 'ReservationTileViewModelBase', context: context);

  @override
  void setModel(ReservationModel xmodel) {
    final _$actionInfo = _$ReservationTileViewModelBaseActionController
        .startAction(name: 'ReservationTileViewModelBase.setModel');
    try {
      return super.setModel(xmodel);
    } finally {
      _$ReservationTileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectAdvert(ReservationModel xmodel, BuildContext context) {
    final _$actionInfo = _$ReservationTileViewModelBaseActionController
        .startAction(name: 'ReservationTileViewModelBase.selectAdvert');
    try {
      return super.selectAdvert(xmodel, context);
    } finally {
      _$ReservationTileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
model: ${model},
isLoading: ${isLoading},
userImage: ${userImage},
userName: ${userName}
    ''';
  }
}
