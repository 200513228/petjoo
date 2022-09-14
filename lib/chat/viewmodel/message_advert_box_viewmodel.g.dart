// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_advert_box_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageAdvertBoxViewModel on MessageAdvertBoxViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'MessageAdvertBoxViewModelBase.isLoading', context: context);

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
      Atom(name: 'MessageAdvertBoxViewModelBase.model', context: context);

  @override
  ChatAdvertModel? get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(ChatAdvertModel? value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  late final _$titleAtom =
      Atom(name: 'MessageAdvertBoxViewModelBase.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$imageAtom =
      Atom(name: 'MessageAdvertBoxViewModelBase.image', context: context);

  @override
  String get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(String value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$getAdvertInfoAsyncAction = AsyncAction(
      'MessageAdvertBoxViewModelBase.getAdvertInfo',
      context: context);

  @override
  Future<dynamic> getAdvertInfo() {
    return _$getAdvertInfoAsyncAction.run(() => super.getAdvertInfo());
  }

  late final _$MessageAdvertBoxViewModelBaseActionController =
      ActionController(name: 'MessageAdvertBoxViewModelBase', context: context);

  @override
  void setModel(ChatAdvertModel xmodel) {
    final _$actionInfo = _$MessageAdvertBoxViewModelBaseActionController
        .startAction(name: 'MessageAdvertBoxViewModelBase.setModel');
    try {
      return super.setModel(xmodel);
    } finally {
      _$MessageAdvertBoxViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
model: ${model},
title: ${title},
image: ${image}
    ''';
  }
}
