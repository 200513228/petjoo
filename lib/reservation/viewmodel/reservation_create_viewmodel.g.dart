// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_create_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReservationCreateViewModel on ReservationCreateViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ReservationCreateViewModelBase.isLoading', context: context);

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

  late final _$modelAtom =
      Atom(name: 'ReservationCreateViewModelBase.model', context: context);

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

  late final _$advertModelAtom = Atom(
      name: 'ReservationCreateViewModelBase.advertModel', context: context);

  @override
  TransportAdvertModel? get advertModel {
    _$advertModelAtom.reportRead();
    return super.advertModel;
  }

  @override
  set advertModel(TransportAdvertModel? value) {
    _$advertModelAtom.reportWrite(value, super.advertModel, () {
      super.advertModel = value;
    });
  }

  late final _$nameContAtom =
      Atom(name: 'ReservationCreateViewModelBase.nameCont', context: context);

  @override
  TextEditingController get nameCont {
    _$nameContAtom.reportRead();
    return super.nameCont;
  }

  @override
  set nameCont(TextEditingController value) {
    _$nameContAtom.reportWrite(value, super.nameCont, () {
      super.nameCont = value;
    });
  }

  late final _$descContAtom =
      Atom(name: 'ReservationCreateViewModelBase.descCont', context: context);

  @override
  TextEditingController get descCont {
    _$descContAtom.reportRead();
    return super.descCont;
  }

  @override
  set descCont(TextEditingController value) {
    _$descContAtom.reportWrite(value, super.descCont, () {
      super.descCont = value;
    });
  }

  late final _$phoneContAtom =
      Atom(name: 'ReservationCreateViewModelBase.phoneCont', context: context);

  @override
  TextEditingController get phoneCont {
    _$phoneContAtom.reportRead();
    return super.phoneCont;
  }

  @override
  set phoneCont(TextEditingController value) {
    _$phoneContAtom.reportWrite(value, super.phoneCont, () {
      super.phoneCont = value;
    });
  }

  late final _$beginGeoPointAtom = Atom(
      name: 'ReservationCreateViewModelBase.beginGeoPoint', context: context);

  @override
  GeoPoint? get beginGeoPoint {
    _$beginGeoPointAtom.reportRead();
    return super.beginGeoPoint;
  }

  @override
  set beginGeoPoint(GeoPoint? value) {
    _$beginGeoPointAtom.reportWrite(value, super.beginGeoPoint, () {
      super.beginGeoPoint = value;
    });
  }

  late final _$endGeoPointAtom = Atom(
      name: 'ReservationCreateViewModelBase.endGeoPoint', context: context);

  @override
  GeoPoint? get endGeoPoint {
    _$endGeoPointAtom.reportRead();
    return super.endGeoPoint;
  }

  @override
  set endGeoPoint(GeoPoint? value) {
    _$endGeoPointAtom.reportWrite(value, super.endGeoPoint, () {
      super.endGeoPoint = value;
    });
  }

  late final _$dialCodeAtom =
      Atom(name: 'ReservationCreateViewModelBase.dialCode', context: context);

  @override
  String? get dialCode {
    _$dialCodeAtom.reportRead();
    return super.dialCode;
  }

  @override
  set dialCode(String? value) {
    _$dialCodeAtom.reportWrite(value, super.dialCode, () {
      super.dialCode = value;
    });
  }

  late final _$animalAtom =
      Atom(name: 'ReservationCreateViewModelBase.animal', context: context);

  @override
  int? get animal {
    _$animalAtom.reportRead();
    return super.animal;
  }

  @override
  set animal(int? value) {
    _$animalAtom.reportWrite(value, super.animal, () {
      super.animal = value;
    });
  }

  late final _$setBeginAsyncAction =
      AsyncAction('ReservationCreateViewModelBase.setBegin', context: context);

  @override
  Future<dynamic> setBegin(BuildContext context) {
    return _$setBeginAsyncAction.run(() => super.setBegin(context));
  }

  late final _$setEndAsyncAction =
      AsyncAction('ReservationCreateViewModelBase.setEnd', context: context);

  @override
  Future<dynamic> setEnd(BuildContext context) {
    return _$setEndAsyncAction.run(() => super.setEnd(context));
  }

  late final _$saveAsyncAction =
      AsyncAction('ReservationCreateViewModelBase.save', context: context);

  @override
  Future<dynamic> save(BuildContext context) {
    return _$saveAsyncAction.run(() => super.save(context));
  }

  late final _$ReservationCreateViewModelBaseActionController =
      ActionController(
          name: 'ReservationCreateViewModelBase', context: context);

  @override
  void setModels(ReservationModel xmodel, TransportAdvertModel xadvertModel) {
    final _$actionInfo = _$ReservationCreateViewModelBaseActionController
        .startAction(name: 'ReservationCreateViewModelBase.setModels');
    try {
      return super.setModels(xmodel, xadvertModel);
    } finally {
      _$ReservationCreateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void error(BuildContext _, String error) {
    final _$actionInfo = _$ReservationCreateViewModelBaseActionController
        .startAction(name: 'ReservationCreateViewModelBase.error');
    try {
      return super.error(_, error);
    } finally {
      _$ReservationCreateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$ReservationCreateViewModelBaseActionController
        .startAction(name: 'ReservationCreateViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$ReservationCreateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
model: ${model},
advertModel: ${advertModel},
nameCont: ${nameCont},
descCont: ${descCont},
phoneCont: ${phoneCont},
beginGeoPoint: ${beginGeoPoint},
endGeoPoint: ${endGeoPoint},
dialCode: ${dialCode},
animal: ${animal}
    ''';
  }
}
