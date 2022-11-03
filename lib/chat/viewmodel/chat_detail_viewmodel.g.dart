// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_detail_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatDetailViewModel on ChatDetailViewModelBase, Store {
  late final _$messageListAtom =
      Atom(name: 'ChatDetailViewModelBase.messageList', context: context);

  @override
  List<dynamic> get messageList {
    _$messageListAtom.reportRead();
    return super.messageList;
  }

  @override
  set messageList(List<dynamic> value) {
    _$messageListAtom.reportWrite(value, super.messageList, () {
      super.messageList = value;
    });
  }

  late final _$messagesAtom =
      Atom(name: 'ChatDetailViewModelBase.messages', context: context);

  @override
  List<dynamic> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(List<dynamic> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$advertsAtom =
      Atom(name: 'ChatDetailViewModelBase.adverts', context: context);

  @override
  List<dynamic> get adverts {
    _$advertsAtom.reportRead();
    return super.adverts;
  }

  @override
  set adverts(List<dynamic> value) {
    _$advertsAtom.reportWrite(value, super.adverts, () {
      super.adverts = value;
    });
  }

  late final _$chatModelAtom =
      Atom(name: 'ChatDetailViewModelBase.chatModel', context: context);

  @override
  ChatModel? get chatModel {
    _$chatModelAtom.reportRead();
    return super.chatModel;
  }

  @override
  set chatModel(ChatModel? value) {
    _$chatModelAtom.reportWrite(value, super.chatModel, () {
      super.chatModel = value;
    });
  }

  late final _$advertModelAtom =
      Atom(name: 'ChatDetailViewModelBase.advertModel', context: context);

  @override
  ChatAdvertModel? get advertModel {
    _$advertModelAtom.reportRead();
    return super.advertModel;
  }

  @override
  set advertModel(ChatAdvertModel? value) {
    _$advertModelAtom.reportWrite(value, super.advertModel, () {
      super.advertModel = value;
    });
  }

  late final _$contAtom =
      Atom(name: 'ChatDetailViewModelBase.cont', context: context);

  @override
  TextEditingController get cont {
    _$contAtom.reportRead();
    return super.cont;
  }

  @override
  set cont(TextEditingController value) {
    _$contAtom.reportWrite(value, super.cont, () {
      super.cont = value;
    });
  }

  late final _$isBlockedAtom =
      Atom(name: 'ChatDetailViewModelBase.isBlocked', context: context);

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

  late final _$isYouBlockedAtom =
      Atom(name: 'ChatDetailViewModelBase.isYouBlocked', context: context);

  @override
  bool get isYouBlocked {
    _$isYouBlockedAtom.reportRead();
    return super.isYouBlocked;
  }

  @override
  set isYouBlocked(bool value) {
    _$isYouBlockedAtom.reportWrite(value, super.isYouBlocked, () {
      super.isYouBlocked = value;
    });
  }

  late final _$setChatModelAsyncAction =
      AsyncAction('ChatDetailViewModelBase.setChatModel', context: context);

  @override
  Future<dynamic> setChatModel(ChatModel model, ChatAdvertModel? xadvertModel) {
    return _$setChatModelAsyncAction
        .run(() => super.setChatModel(model, xadvertModel));
  }

  late final _$getMessagesAsyncAction =
      AsyncAction('ChatDetailViewModelBase.getMessages', context: context);

  @override
  Future<dynamic> getMessages(String id) {
    return _$getMessagesAsyncAction.run(() => super.getMessages(id));
  }

  late final _$sendMessageAsyncAction =
      AsyncAction('ChatDetailViewModelBase.sendMessage', context: context);

  @override
  Future<dynamic> sendMessage(ChatModel model) {
    return _$sendMessageAsyncAction.run(() => super.sendMessage(model));
  }

  late final _$reportAsyncAction =
      AsyncAction('ChatDetailViewModelBase.report', context: context);

  @override
  Future<dynamic> report(BuildContext context) {
    return _$reportAsyncAction.run(() => super.report(context));
  }

  late final _$checkBlockAsyncAction =
      AsyncAction('ChatDetailViewModelBase.checkBlock', context: context);

  @override
  Future<dynamic> checkBlock(String uid) {
    return _$checkBlockAsyncAction.run(() => super.checkBlock(uid));
  }

  late final _$blockUserAsyncAction =
      AsyncAction('ChatDetailViewModelBase.blockUser', context: context);

  @override
  Future<dynamic> blockUser(BuildContext context, String uid) {
    return _$blockUserAsyncAction.run(() => super.blockUser(context, uid));
  }

  late final _$unblockUserAsyncAction =
      AsyncAction('ChatDetailViewModelBase.unblockUser', context: context);

  @override
  Future<dynamic> unblockUser(BuildContext context, String uid) {
    return _$unblockUserAsyncAction.run(() => super.unblockUser(context, uid));
  }

  @override
  String toString() {
    return '''
messageList: ${messageList},
messages: ${messages},
adverts: ${adverts},
chatModel: ${chatModel},
advertModel: ${advertModel},
cont: ${cont},
isBlocked: ${isBlocked},
isYouBlocked: ${isYouBlocked}
    ''';
  }
}
