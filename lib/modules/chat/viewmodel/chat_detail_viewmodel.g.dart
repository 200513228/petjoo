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
  List<MessageModel> get messageList {
    _$messageListAtom.reportRead();
    return super.messageList;
  }

  @override
  set messageList(List<MessageModel> value) {
    _$messageListAtom.reportWrite(value, super.messageList, () {
      super.messageList = value;
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
cont: ${cont},
isBlocked: ${isBlocked}
    ''';
  }
}
