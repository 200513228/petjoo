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

  late final _$nextStepAsyncAction =
      AsyncAction('StoreAddViewModelBase.nextStep', context: context);

  @override
  Future<dynamic> nextStep(BuildContext context,
      {required String title,
      required String description,
      required String dialCode,
      required String phone,
      required int type}) {
    return _$nextStepAsyncAction.run(() => super.nextStep(context,
        title: title,
        description: description,
        dialCode: dialCode,
        phone: phone,
        type: type));
  }

  @override
  String toString() {
    return '''
advert: ${advert}
    ''';
  }
}
