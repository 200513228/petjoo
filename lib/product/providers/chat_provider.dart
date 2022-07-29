import 'dart:async';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/product/models/chat_model.dart';
import 'package:petjoo/product/models/message_model.dart';
import 'package:petjoo/product/network/requests.dart';

class ChatProvider extends ChangeNotifier {
  StreamSubscription<List<ChatModel>>? _stream;
  List<ChatModel> chats = [];

  ChatProvider() {
    FirebaseAuth.instance.authStateChanges().listen((event) => event?.isAnonymous == false ? _startListen() : _stopListen());
  }

  void _startListen() {
    if (_stream != null) return;
    _stream = Requests.getChats(FirebaseAuth.instance.currentUser!.uid).listen(_onChatsNotify);
  }

  void _stopListen() {
    _stream?.cancel();
    _stream = null;
    chats.clear();
    notifyListeners();
  }

  void _onChatsNotify(List<ChatModel> event) {
    for (var chat in event) {
      final oldChat = chats.firstOrNullWhere((x) => x.id == chat.id);
      if (oldChat != null) {
        chat.user = oldChat.user;
        chat.messages = oldChat.messages;
      }
    }
    chats = event;
    notifyListeners();
  }

  int get unReadedChatsCount => chats.where((x) => !x.isReaded).length;

  bool hasChat(String chatId) => chats.any((x) => x.id == chatId);

  void addMessage(String chatId, MessageModel message) {
    chats.firstOrNullWhere((x) => x.id == chatId)?.messages.insert(0, message);
    notifyListeners();
  }

  void addMessages(String chatId, List<MessageModel> messages) {
    chats.firstOrNullWhere((x) => x.id == chatId)?.messages.insertAll(0, messages);
    notifyListeners();
  }

  void addOldMessages(String chatId, List<MessageModel> messages) {
    chats.firstOrNullWhere((x) => x.id == chatId)?.messages.addAll(messages);
    notifyListeners();
  }
}
