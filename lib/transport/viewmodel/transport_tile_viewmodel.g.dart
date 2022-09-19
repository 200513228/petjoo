// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_tile_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransportTileViewModel on TransportTileViewModelBase, Store {
  late final _$advertAtom =
      Atom(name: 'TransportTileViewModelBase.advert', context: context);

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

  late final _$callAsyncAction =
      AsyncAction('TransportTileViewModelBase.call', context: context);

  @override
  Future<dynamic> call() {
    return _$callAsyncAction.run(() => super.call());
  }

  late final _$messageAsyncAction =
      AsyncAction('TransportTileViewModelBase.message', context: context);

  @override
  Future<dynamic> message(BuildContext _) {
    return _$messageAsyncAction.run(() => super.message(_));
  }

  late final _$TransportTileViewModelBaseActionController =
      ActionController(name: 'TransportTileViewModelBase', context: context);

  @override
  void setModel(TransportAdvertModel model) {
    final _$actionInfo = _$TransportTileViewModelBaseActionController
        .startAction(name: 'TransportTileViewModelBase.setModel');
    try {
      return super.setModel(model);
    } finally {
      _$TransportTileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectAdvert(TransportAdvertModel model, BuildContext context) {
    final _$actionInfo = _$TransportTileViewModelBaseActionController
        .startAction(name: 'TransportTileViewModelBase.selectAdvert');
    try {
      return super.selectAdvert(model, context);
    } finally {
      _$TransportTileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
advert: ${advert}
    ''';
  }
}
