// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_add_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoreAddViewModel on StoreAddViewModelBase, Store {
  late final _$advertAtom =
      Atom(name: 'StoreAddViewModelBase.advert', context: context);

  @override
  StoreAdvertModel get advert {
    _$advertAtom.reportRead();
    return super.advert;
  }

  @override
  set advert(StoreAdvertModel value) {
    _$advertAtom.reportWrite(value, super.advert, () {
      super.advert = value;
    });
  }

  late final _$formKeyAtom =
      Atom(name: 'StoreAddViewModelBase.formKey', context: context);

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
      Atom(name: 'StoreAddViewModelBase.titleCont', context: context);

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
      Atom(name: 'StoreAddViewModelBase.descCont', context: context);

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
      Atom(name: 'StoreAddViewModelBase.phoneCont', context: context);

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

  late final _$priceContAtom =
      Atom(name: 'StoreAddViewModelBase.priceCont', context: context);

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

  late final _$addressContAtom =
      Atom(name: 'StoreAddViewModelBase.addressCont', context: context);

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

  late final _$dialCodeAtom =
      Atom(name: 'StoreAddViewModelBase.dialCode', context: context);

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

  late final _$priceAtom =
      Atom(name: 'StoreAddViewModelBase.price', context: context);

  @override
  int? get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(int? value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  late final _$typeAtom =
      Atom(name: 'StoreAddViewModelBase.type', context: context);

  @override
  int? get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(int? value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  late final _$deliveryAtom =
      Atom(name: 'StoreAddViewModelBase.delivery', context: context);

  @override
  int? get delivery {
    _$deliveryAtom.reportRead();
    return super.delivery;
  }

  @override
  set delivery(int? value) {
    _$deliveryAtom.reportWrite(value, super.delivery, () {
      super.delivery = value;
    });
  }

  late final _$statusAtom =
      Atom(name: 'StoreAddViewModelBase.status', context: context);

  @override
  int? get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(int? value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$nextStepAsyncAction =
      AsyncAction('StoreAddViewModelBase.nextStep', context: context);

  @override
  Future<dynamic> nextStep(BuildContext context) {
    return _$nextStepAsyncAction.run(() => super.nextStep(context));
  }

  @override
  String toString() {
    return '''
advert: ${advert},
formKey: ${formKey},
titleCont: ${titleCont},
descCont: ${descCont},
phoneCont: ${phoneCont},
priceCont: ${priceCont},
addressCont: ${addressCont},
dialCode: ${dialCode},
price: ${price},
type: ${type},
delivery: ${delivery},
status: ${status}
    ''';
  }
}
