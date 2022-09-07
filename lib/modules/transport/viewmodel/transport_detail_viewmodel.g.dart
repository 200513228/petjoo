// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_detail_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransportDetailViewModel on TransportDetailViewModelBase, Store {
  late final _$advertAtom =
      Atom(name: 'TransportDetailViewModelBase.advert', context: context);

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

  late final _$changeActiveAsyncAction = AsyncAction(
      'TransportDetailViewModelBase.changeActive',
      context: context);

  @override
  Future<dynamic> changeActive(BuildContext _) {
    return _$changeActiveAsyncAction.run(() => super.changeActive(_));
  }

  late final _$callAsyncAction =
      AsyncAction('TransportDetailViewModelBase.call', context: context);

  @override
  Future<dynamic> call() {
    return _$callAsyncAction.run(() => super.call());
  }

  late final _$messageAsyncAction =
      AsyncAction('TransportDetailViewModelBase.message', context: context);

  @override
  Future<dynamic> message(BuildContext _) {
    return _$messageAsyncAction.run(() => super.message(_));
  }

  late final _$openCurrentChatAsyncAction = AsyncAction(
      'TransportDetailViewModelBase.openCurrentChat',
      context: context);

  @override
  Future<dynamic> openCurrentChat(BuildContext _, String id) {
    return _$openCurrentChatAsyncAction.run(() => super.openCurrentChat(_, id));
  }

  late final _$TransportDetailViewModelBaseActionController =
      ActionController(name: 'TransportDetailViewModelBase', context: context);

  @override
  void setModel(TransportAdvertModel model) {
    final _$actionInfo = _$TransportDetailViewModelBaseActionController
        .startAction(name: 'TransportDetailViewModelBase.setModel');
    try {
      return super.setModel(model);
    } finally {
      _$TransportDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void edit(BuildContext context) {
    final _$actionInfo = _$TransportDetailViewModelBaseActionController
        .startAction(name: 'TransportDetailViewModelBase.edit');
    try {
      return super.edit(context);
    } finally {
      _$TransportDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void error(BuildContext _, String data) {
    final _$actionInfo = _$TransportDetailViewModelBaseActionController
        .startAction(name: 'TransportDetailViewModelBase.error');
    try {
      return super.error(_, data);
    } finally {
      _$TransportDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$TransportDetailViewModelBaseActionController
        .startAction(name: 'TransportDetailViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$TransportDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
advert: ${advert}
    ''';
  }
}
