import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/product/models/chat_model.dart';
import 'package:petjoo/product/models/message_model.dart';
import 'package:petjoo/product/network/requests.dart';
import 'package:petjoo/product/providers/chat_provider.dart';

class ChatMessageListViewModel extends PageNotifier {
  ChatMessageListViewModel(BuildContext context, this.chat, this._chatProvider) : super(context) {
    _chatProvider.addListener(_onChatsNotify);
    _onChatsNotify();
  }

  final String userId = FirebaseAuth.instance.currentUser!.uid;
  late final String targetUserId = chat.userIds.firstWhere((x) => x != userId);
  final ChatProvider _chatProvider;
  ChatModel chat;
  TextEditingController messageController = TextEditingController();
  late final scrollController = ScrollController()..addListener(_scrollListener);

  void sendMessage() async {
    if (chat.id == null) await createChat();
    if (messageController.text.trim().isEmpty) return;
    final message = MessageModel(content: messageController.text, senderId: userId, date: DateTime.now());
    messageController.text = "";
    try {
      addMessage(chat.id!, message);
      notifyListeners();
      final result = await Requests.createMessage(chat.id!, message);
      message.id = result.id;
      notifyListeners();
    } catch (e) {
      message.id = "";
      notifyListeners();
    }
  }

  Future<void> createChat() async {
    chat.id = chat.userIds.join("_");
    _chatProvider.chats.add(chat);
    await Requests.createChat(chat);
  }

  void addMessage(String matchId, MessageModel message) => _chatProvider.addMessage(matchId, message);

  Future<void> getMoreMessages() async {
    _chatProvider.addOldMessages(chat.id!, await Requests.getOldMessages(chat.id!, lastDocument: chat.messages.last.document));
    notifyListeners();
  }

  void _onChatsNotify() async {
    if (chat.id == null) return;
    chat = _chatProvider.chats.firstWhere((x) => x.id == chat.id);
    if (chat.messages.any((x) => x.id == chat.lastMessage.id)) return;

    _chatProvider.addMessages(chat.id!, await Requests.getMessages(chat.id!, lastDocument: chat.messages.firstOrNull?.document));

    //final targetId = _chat.users.firstWhere((x) => x.id != FirebaseAuth.instance.currentUser?.uid).id;
    chat.messages
        .where((x) => x.senderId == targetUserId && !x.isReaded)
        .forEach((message) => message.document?.reference.update({'isReaded': true}));
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      log("Bottom Of the List");
      getMoreMessages();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    _chatProvider.removeListener(_onChatsNotify);
    super.dispose();
  }

  void block() => Requests.blockUser(targetUserId);

  void unblock() => Requests.unblockUser(targetUserId);

  void getUser() async {
    if (chat.user != null) return;
    chat.user = await Requests.getUserInfo(targetUserId);
    notifyListeners();
  }
}
