// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_tile_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatTileViewModel on ChatTileViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ChatTileViewModelBase.isLoading', context: context);

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

  late final _$imageAtom =
      Atom(name: 'ChatTileViewModelBase.image', context: context);

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

  late final _$nameAtom =
      Atom(name: 'ChatTileViewModelBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$isBlockedAtom =
      Atom(name: 'ChatTileViewModelBase.isBlocked', context: context);

  @override
  bool get isBlocked {
    _$isBlockedAtom.reportRead();
    return super.isBlocked;
  }

  @override
  set isBlocked(bool value) {
    _$isBlockedAtom.reportWrite(value, super.isBlocked, () {
      super.isBlocked = value;
    });
  }

  late final _$getUserInfoAsyncAction =
      AsyncAction('ChatTileViewModelBase.getUserInfo', context: context);

  @override
  Future<dynamic> getUserInfo(String userId) {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo(userId));
  }

  late final _$readChatAsyncAction =
      AsyncAction('ChatTileViewModelBase.readChat', context: context);

  @override
  Future<dynamic> readChat(String doc) {
    return _$readChatAsyncAction.run(() => super.readChat(doc));
  }

  late final _$ChatTileViewModelBaseActionController =
      ActionController(name: 'ChatTileViewModelBase', context: context);

  @override
  void checkBlock(String userId) {
    final _$actionInfo = _$ChatTileViewModelBaseActionController.startAction(
        name: 'ChatTileViewModelBase.checkBlock');
    try {
      return super.checkBlock(userId);
    } finally {
      _$ChatTileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openChat(BuildContext context, ChatModel model) {
    final _$actionInfo = _$ChatTileViewModelBaseActionController.startAction(
        name: 'ChatTileViewModelBase.openChat');
    try {
      return super.openChat(context, model);
    } finally {
      _$ChatTileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
image: ${image},
name: ${name},
isBlocked: ${isBlocked}
    ''';
  }
}
