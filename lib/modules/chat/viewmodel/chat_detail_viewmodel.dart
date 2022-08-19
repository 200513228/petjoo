import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
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
    List<MessageModel> temp = [];
    var data = await ChatService.getMessages(id);
    for (var element in data.docs) {
      temp.add(MessageModel.fromQDS(element));
    }
    messageList = temp;
  }

  @action
  Future sendMessage(String doc) async {
    String text = cont.text;
    cont.clear();
    if (text != '') {
      List<MessageModel> temp = messageList;
      await ChatService.sendMessage(MessageModel.toMap(text), doc);
      temp.add(MessageModel.fromMap(MessageModel.toMap(text)));
      messageList = temp;
    }
  }
}
