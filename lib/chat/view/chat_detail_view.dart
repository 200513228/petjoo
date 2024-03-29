import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/string_converters.dart';
import 'package:petjoo/chat/model/chat_advert_model.dart';
import 'package:petjoo/chat/model/chat_model.dart';
import 'package:petjoo/chat/model/message_model.dart';
import 'package:petjoo/chat/view/message_advert_box_view.dart';
import 'package:petjoo/chat/viewmodel/chat_detail_viewmodel.dart';
import 'package:petjoo/user/model/current_user.dart';

class ChatDetailView extends StatelessWidget {
  final ChatModel model;
  final String name;
  final ChatAdvertModel? advertModel;
  final ChatDetailViewModel vm = ChatDetailViewModel();
  ChatDetailView(
      {required this.model, required this.name, this.advertModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setChatModel(model, advertModel);
    List findUser = vm.chatModel!.userIds;
    findUser.remove(CurrentUser.id);
    vm.getMessages(vm.chatModel!.id);
    vm.checkBlock(findUser.first);
    return Observer(builder: (_) {
      return Scaffold(
        appBar: buildAppBar(context, findUser.first),
        body: (vm.isBlocked || vm.isYouBlocked) ? blockBody() : buildBody(),
      );
    });
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(child: messageList()),
        textRow(),
      ],
    );
  }

  Widget blockBody() {
    return Container(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            vm.isBlocked ? 'blockuser_content'.tr() : 'blockuser_content2'.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget messageList() {
    return Observer(builder: (_) {
      return ListView(
        reverse: true,
        children: [
          ...vm.messageList.map((e) {
            return (e.runtimeType.toString() == 'MessageModel')
                ? messageBox(e)
                : MessageAdvertBoxView(model: e);
          })
        ],
      );
    });
  }

  Widget messageBox(MessageModel model) {
    final bool isUser = model.senderId == CurrentUser.id;
    return Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: isUser ? Colors.black : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
                bottomRight: isUser ? Radius.zero : const Radius.circular(20)),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                        child: Text(
                          model.content,
                          style: TextStyle(
                              fontSize: 15,
                              color: isUser ? Colors.white : Colors.black),
                        ))),
                Text(
                  hourToString(
                      '${model.date.toDate().hour}:${model.date.toDate().minute}'),
                  style: TextStyle(
                      color: isUser ? Colors.white54 : Colors.black54),
                )
              ]),
        ));
  }

  Widget textRow() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, left: 15, right: 10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: vm.cont,
            maxLength: 255,
            maxLines: 3,
            minLines: 1,
            decoration:
                InputDecoration(hintText: 'chat_message'.tr(), counterText: ''),
          )),
          const SizedBox(width: 15),
          IconButton(
              onPressed: () => vm.sendMessage(vm.chatModel!),
              icon: const Icon(Icons.send),
              color: Colors.black),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, String uid) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_horiz, color: Colors.black),
          color: Colors.black,
          itemBuilder: (context) => [
            PopupMenuItem(
                onTap: () => vm.isBlocked
                    ? vm.unblockUser(context, uid)
                    : vm.blockUser(context, uid),
                child: Text(
                  vm.isBlocked ? 'unblock'.tr() : 'block'.tr(),
                  style: const TextStyle(color: Colors.red),
                )),
            PopupMenuItem(
                onTap: () => vm.report(context),
                child: Text(
                  'report'.tr(),
                  style: const TextStyle(color: Colors.white),
                ))
          ],
        ),
      ],
      title: Text(name,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }
}
