import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_advert_model.dart';
import 'package:petjoo/chat/model/chat_model.dart';
import 'package:petjoo/chat/model/message_model.dart';
import 'package:petjoo/chat/service/chat_service.dart';
import 'package:petjoo/home/service/report_service.dart';
import 'package:petjoo/ui/please_auth.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:petjoo/user/service/user_service.dart';

part 'chat_detail_viewmodel.g.dart';

class ChatDetailViewModel = ChatDetailViewModelBase with _$ChatDetailViewModel;

abstract class ChatDetailViewModelBase with Store {
  @observable
  List<dynamic> messageList = [];
  @observable
  List<dynamic> messages = [];
  @observable
  List<dynamic> adverts = [];
  @observable
  ChatModel? chatModel;
  @observable
  ChatAdvertModel? advertModel;
  @observable
  TextEditingController cont = TextEditingController();
  @observable
  bool isBlocked = false;
  @observable
  bool isYouBlocked = false;

  @action
  Future setChatModel(ChatModel model, ChatAdvertModel? xadvertModel) async {
    chatModel = model;
    advertModel = xadvertModel;
  }

  @action
  Future getMessages(String id) async {
    List<dynamic> temp = [];
    List<dynamic> advertsTemp = [];
    var advertData = await ChatService.getAdverts(id);
    for (var element in advertData.docs) {
      advertsTemp.add(ChatAdvertModel.fromQDS(element));
    }
    var messageStream = ChatService.getMessages(id);
    messageStream.listen((event) {
      messages = event.docs.map((e) => MessageModel.fromQDS(e)).toList();
      temp = advertsTemp + messages;
      temp.sort((b, a) {
        var adate = a.date as Timestamp;
        var bdate = b.date as Timestamp;
        return adate.microsecondsSinceEpoch
            .compareTo(bdate.microsecondsSinceEpoch);
      });
      messageList = temp;
    });
  }

  @action
  Future sendMessage(ChatModel model) async {
    String text = cont.text;
    cont.clear();
    if (text != '') {
      await ChatService.sendMessage(
          MessageModel.toMap(text), model, model.userIds.first);
    }
    if (advertModel != null) {
      await ChatService.sendAdvert(ChatAdvertModel.toMap(advertModel!), model);
      advertModel = null;
    }
  }

  @action
  Future report(BuildContext context) async {
    if (CurrentUser.id == '') {
      showDialog(context: context, builder: (context) => const PleaseAuth());
    } else {
      await ReportService.sendReport({
        'date': Timestamp.now(),
        'doc': chatModel!.id,
        'col': 'chats',
        'userId': CurrentUser.id,
        'status': false,
      }).then((value) => value == 'REPORT'
          ? ScaffoldMessenger.of(context)
              .showSnackBar(uiSnackBar('Rapor başarıyla gönderildi.'))
          : ScaffoldMessenger.of(context).showSnackBar(
              uiSnackBar('Rapor gönderilirken bir hata oluştu.')));
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
