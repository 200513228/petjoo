import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/chat/model/chat_model.dart';
import 'package:petjoo/modules/chat/model/message_model.dart';
import 'package:petjoo/modules/chat/service/chat_service.dart';

part 'chat_detail_viewmodel.g.dart';

class ChatDetailViewModel = ChatDetailViewModelBase with _$ChatDetailViewModel;

abstract class ChatDetailViewModelBase with Store {
  @observable
  List<MessageModel> messageList = [];

  @observable
  TextEditingController cont = TextEditingController();

  @action
  Future getMessages(String id) async {
    var stream = ChatService.getMessages(id);
    stream.listen((event) {
      messageList = event.docs.map((e) => MessageModel.fromQDS(e)).toList();
    });
  }

  @action
  Future sendMessage(ChatModel model) async {
    String text = cont.text;
    cont.clear();
    if (text != '') {
      await ChatService.sendMessage(MessageModel.toMap(text), model);
    }
  }
}
