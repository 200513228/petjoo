import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/chat/model/chat_model.dart';
import 'package:petjoo/modules/chat/model/message_model.dart';
import 'package:petjoo/modules/chat/viewmodel/chat_detail_viewmodel.dart';
import 'package:petjoo/modules/user/model/current_user.dart';

class ChatDetailView extends StatelessWidget {
  final ChatModel model;
  final String name;
  final ChatDetailViewModel vm = ChatDetailViewModel();
  ChatDetailView({required this.model, required this.name, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.getMessages(model.id);
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(child: messageList()),
        textRow(),
      ],
    );
  }

  Widget messageList() {
    return Observer(builder: (_) {
      return ListView(
        reverse: true,
        children: [...vm.messageList.map((e) => messageBox(e))],
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
                  dateToTime(model.date),
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
                const InputDecoration(hintText: 'Mesaj', counterText: ''),
          )),
          const SizedBox(width: 15),
          IconButton(
              onPressed: () {
                vm.sendMessage(model);
              },
              icon: const Icon(Icons.send),
              color: Colors.black),
        ],
      ),
    );
  }

  String dateToTime(Timestamp date) {
    var d = date.toDate();
    return '${d.hour}:${d.minute}';
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Hero(
          tag: 'name',
          child: Material(
              type: MaterialType.transparency,
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ))),
    );
  }
}
