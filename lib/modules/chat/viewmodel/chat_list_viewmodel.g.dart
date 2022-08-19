// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatListViewModel on ChatListViewModelBase, Store {
  late final _$chatListAtom =
      Atom(name: 'ChatListViewModelBase.chatList', context: context);

  @override
  List<ChatModel> get chatList {
    _$chatListAtom.reportRead();
    return super.chatList;
  }

  @override
  set chatList(List<ChatModel> value) {
    _$chatListAtom.reportWrite(value, super.chatList, () {
      super.chatList = value;
    });
  }

  late final _$getChatsAsyncAction =
      AsyncAction('ChatListViewModelBase.getChats', context: context);

  @override
  Future<dynamic> getChats() {
    return _$getChatsAsyncAction.run(() => super.getChats());
  }

  @override
  String toString() {
    return '''
chatList: ${chatList}
    ''';
  }
}
