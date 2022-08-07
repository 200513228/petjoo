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
  String toString() {
    return '''
advert: ${advert}
    ''';
  }
}
