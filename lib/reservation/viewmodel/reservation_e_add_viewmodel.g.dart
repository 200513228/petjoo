// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_e_add_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReservationEAddViewModel on ReservationEAddViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ReservationEAddViewModelBase.isLoading', context: context);

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
      Atom(name: 'ReservationEAddViewModelBase.model', context: context);

  @override
  ReservationModel get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(ReservationModel value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  late final _$advertModelAtom =
      Atom(name: 'ReservationEAddViewModelBase.advertModel', context: context);

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
      Atom(name: 'ReservationEAddViewModelBase.nameCont', context: context);

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
      Atom(name: 'ReservationEAddViewModelBase.descCont', context: context);

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
      Atom(name: 'ReservationEAddViewModelBase.phoneCont', context: context);

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
      name: 'ReservationEAddViewModelBase.beginGeoPoint', context: context);

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

  late final _$endGeoPointAtom =
      Atom(name: 'ReservationEAddViewModelBase.endGeoPoint', context: context);

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

  late final _$formKeyAtom =
      Atom(name: 'ReservationEAddViewModelBase.formKey', context: context);

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  late final _$dialCodeAtom =
      Atom(name: 'ReservationEAddViewModelBase.dialCode', context: context);

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
      Atom(name: 'ReservationEAddViewModelBase.animal', context: context);

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

  late final _$callAtom =
      Atom(name: 'ReservationEAddViewModelBase.call', context: context);

  @override
  bool get call {
    _$callAtom.reportRead();
    return super.call;
  }

  @override
  set call(bool value) {
    _$callAtom.reportWrite(value, super.call, () {
      super.call = value;
    });
  }

  late final _$setBeginAsyncAction =
      AsyncAction('ReservationEAddViewModelBase.setBegin', context: context);

  @override
  Future<dynamic> setBegin(BuildContext context) {
    return _$setBeginAsyncAction.run(() => super.setBegin(context));
  }

  late final _$setEndAsyncAction =
      AsyncAction('ReservationEAddViewModelBase.setEnd', context: context);

  @override
  Future<dynamic> setEnd(BuildContext context) {
    return _$setEndAsyncAction.run(() => super.setEnd(context));
  }

  late final _$saveAsyncAction =
      AsyncAction('ReservationEAddViewModelBase.save', context: context);

  @override
  Future<String> save(BuildContext context) {
    return _$saveAsyncAction.run(() => super.save(context));
  }

  late final _$calculateAndSaveAsyncAction = AsyncAction(
      'ReservationEAddViewModelBase.calculateAndSave',
      context: context);

  @override
  Future<dynamic> calculateAndSave(BuildContext context) {
    return _$calculateAndSaveAsyncAction
        .run(() => super.calculateAndSave(context));
  }

  late final _$ReservationEAddViewModelBaseActionController =
      ActionController(name: 'ReservationEAddViewModelBase', context: context);

  @override
  void error(BuildContext _, String error) {
    final _$actionInfo = _$ReservationEAddViewModelBaseActionController
        .startAction(name: 'ReservationEAddViewModelBase.error');
    try {
      return super.error(_, error);
    } finally {
      _$ReservationEAddViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$ReservationEAddViewModelBaseActionController
        .startAction(name: 'ReservationEAddViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$ReservationEAddViewModelBaseActionController.endAction(_$actionInfo);
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
formKey: ${formKey},
dialCode: ${dialCode},
animal: ${animal},
call: ${call}
    ''';
  }
}
