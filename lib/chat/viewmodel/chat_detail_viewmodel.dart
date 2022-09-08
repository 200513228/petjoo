import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_model.dart';
import 'package:petjoo/chat/model/message_model.dart';
import 'package:petjoo/chat/service/chat_service.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:petjoo/user/service/user_service.dart';

part 'chat_detail_viewmodel.g.dart';

class ChatDetailViewModel = ChatDetailViewModelBase with _$ChatDetailViewModel;

abstract class ChatDetailViewModelBase with Store {
  @observable
  List<MessageModel> messageList = [];
  @observable
  TextEditingController cont = TextEditingController();
  @observable
  bool isBlocked = false;
  @observable
  bool isYouBlocked = false;

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

  @action
  Future checkBlock(String uid) async {
    var tempList = CurrentUser.blocks.where((element) => element == uid);
    isBlocked = tempList.isNotEmpty;
    List userBlocks = await UserService.getUserBlocks(uid);
    var blockList = userBlocks.where((element) => element == CurrentUser.id);
    isYouBlocked = blockList.isNotEmpty;
  }

  @action
  Future blockUser(BuildContext context, String uid) async {
    await UserService.blockUser(uid).then((value) => Navigator.pop(context));
  }

  @action
  Future unblockUser(BuildContext context, String uid) async {
    await UserService.unblockUser(uid).then((value) => Navigator.pop(context));
  }
}
