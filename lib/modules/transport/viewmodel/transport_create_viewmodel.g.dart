// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_create_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransportCreateViewModel on TransportCreateViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'TransportCreateViewModelBase.isLoading', context: context);

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

  late final _$advertAtom =
      Atom(name: 'TransportCreateViewModelBase.advert', context: context);

  @override
  TransportAdvertModel? get advert {
    _$advertAtom.reportRead();
    return super.advert;
  }

  @override
  set advert(TransportAdvertModel? value) {
    _$advertAtom.reportWrite(value, super.advert, () {
      super.advert = value;
    });
  }

  late final _$formKeyAtom =
      Atom(name: 'TransportCreateViewModelBase.formKey', context: context);

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

  late final _$titleContAtom =
      Atom(name: 'TransportCreateViewModelBase.titleCont', context: context);

  @override
  TextEditingController get titleCont {
    _$titleContAtom.reportRead();
    return super.titleCont;
  }

  @override
  set titleCont(TextEditingController value) {
    _$titleContAtom.reportWrite(value, super.titleCont, () {
      super.titleCont = value;
    });
  }

  late final _$descContAtom =
      Atom(name: 'TransportCreateViewModelBase.descCont', context: context);

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

  late final _$addressContAtom =
      Atom(name: 'TransportCreateViewModelBase.addressCont', context: context);

  @override
  TextEditingController get addressCont {
    _$addressContAtom.reportRead();
    return super.addressCont;
  }

  @override
  set addressCont(TextEditingController value) {
    _$addressContAtom.reportWrite(value, super.addressCont, () {
      super.addressCont = value;
    });
  }

  late final _$priceContAtom =
      Atom(name: 'TransportCreateViewModelBase.priceCont', context: context);

  @override
  TextEditingController get priceCont {
    _$priceContAtom.reportRead();
    return super.priceCont;
  }

  @override
  set priceCont(TextEditingController value) {
    _$priceContAtom.reportWrite(value, super.priceCont, () {
      super.priceCont = value;
    });
  }

  late final _$canCatchAtom =
      Atom(name: 'TransportCreateViewModelBase.canCatch', context: context);

  @override
  bool get canCatch {
    _$canCatchAtom.reportRead();
    return super.canCatch;
  }

  @override
  set canCatch(bool value) {
    _$canCatchAtom.reportWrite(value, super.canCatch, () {
      super.canCatch = value;
    });
  }

  late final _$isIntercityAtom =
      Atom(name: 'TransportCreateViewModelBase.isIntercity', context: context);

  @override
  bool get isIntercity {
    _$isIntercityAtom.reportRead();
    return super.isIntercity;
  }

  @override
  set isIntercity(bool value) {
    _$isIntercityAtom.reportWrite(value, super.isIntercity, () {
      super.isIntercity = value;
    });
  }

  late final _$hasCollarAtom =
      Atom(name: 'TransportCreateViewModelBase.hasCollar', context: context);

  @override
  bool get hasCollar {
    _$hasCollarAtom.reportRead();
    return super.hasCollar;
  }

  @override
  set hasCollar(bool value) {
    _$hasCollarAtom.reportWrite(value, super.hasCollar, () {
      super.hasCollar = value;
    });
  }

  late final _$hasCageAtom =
      Atom(name: 'TransportCreateViewModelBase.hasCage', context: context);

  @override
  bool get hasCage {
    _$hasCageAtom.reportRead();
    return super.hasCage;
  }

  @override
  set hasCage(bool value) {
    _$hasCageAtom.reportWrite(value, super.hasCage, () {
      super.hasCage = value;
    });
  }

  late final _$setAdvertAsyncAction =
      AsyncAction('TransportCreateViewModelBase.setAdvert', context: context);

  @override
  Future<dynamic> setAdvert() {
    return _$setAdvertAsyncAction.run(() => super.setAdvert());
  }

  late final _$nextStepAsyncAction =
      AsyncAction('TransportCreateViewModelBase.nextStep', context: context);

  @override
  Future<dynamic> nextStep(BuildContext context) {
    return _$nextStepAsyncAction.run(() => super.nextStep(context));
  }

  late final _$TransportCreateViewModelBaseActionController =
      ActionController(name: 'TransportCreateViewModelBase', context: context);

  @override
  void editHours(BuildContext context) {
    final _$actionInfo = _$TransportCreateViewModelBaseActionController
        .startAction(name: 'TransportCreateViewModelBase.editHours');
    try {
      return super.editHours(context);
    } finally {
      _$TransportCreateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
advert: ${advert},
formKey: ${formKey},
titleCont: ${titleCont},
descCont: ${descCont},
addressCont: ${addressCont},
priceCont: ${priceCont},
canCatch: ${canCatch},
isIntercity: ${isIntercity},
hasCollar: ${hasCollar},
hasCage: ${hasCage}
    ''';
  }
}
