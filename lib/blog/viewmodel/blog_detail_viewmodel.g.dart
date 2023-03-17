// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_detail_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BlogDetailViewModel on BlogDetailViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'BlogDetailViewModelBase.isLoading', context: context);

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

  late final _$messagesAtom =
      Atom(name: 'BlogDetailViewModelBase.messages', context: context);

  @override
  List<BlogMsgModel> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(List<BlogMsgModel> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$getMessagesAsyncAction =
      AsyncAction('BlogDetailViewModelBase.getMessages', context: context);

  @override
  Future<dynamic> getMessages(String docid) {
    return _$getMessagesAsyncAction.run(() => super.getMessages(docid));
  }

  late final _$sendMessageAsyncAction =
      AsyncAction('BlogDetailViewModelBase.sendMessage', context: context);

  @override
  Future<dynamic> sendMessage(String message, String docid) {
    return _$sendMessageAsyncAction
        .run(() => super.sendMessage(message, docid));
  }

  late final _$updateMessageAsyncAction =
      AsyncAction('BlogDetailViewModelBase.updateMessage', context: context);

  @override
  Future<dynamic> updateMessage(String message, String topicId, String msgId) {
    return _$updateMessageAsyncAction
        .run(() => super.updateMessage(message, topicId, msgId));
  }

  late final _$publishAsyncAction =
      AsyncAction('BlogDetailViewModelBase.publish', context: context);

  @override
  Future<dynamic> publish(BuildContext context, String doc) {
    return _$publishAsyncAction.run(() => super.publish(context, doc));
  }

  late final _$reportAsyncAction =
      AsyncAction('BlogDetailViewModelBase.report', context: context);

  @override
  Future<dynamic> report(BuildContext context, String doc) {
    return _$reportAsyncAction.run(() => super.report(context, doc));
  }

  late final _$deleteTopicAsyncAction =
      AsyncAction('BlogDetailViewModelBase.deleteTopic', context: context);

  @override
  Future<dynamic> deleteTopic(String docid) {
    return _$deleteTopicAsyncAction.run(() => super.deleteTopic(docid));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
messages: ${messages}
    ''';
  }
}
