import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/string_converters.dart';
import 'package:petjoo/blog/model/blog_msg_model.dart';
import 'package:petjoo/blog/model/blog_topic_model.dart';
import 'package:petjoo/blog/viewmodel/blog_detail_viewmodel.dart';
import 'package:petjoo/ui/loading.dart';

class BlogDetailView extends StatelessWidget {
  final BlogDetailViewModel vm = BlogDetailViewModel();
  final BlogTopicModel topic;
  BlogDetailView(this.topic, {super.key});

  @override
  Widget build(BuildContext context) {
    vm.getMessages(topic.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: Observer(builder: (context) {
        return RefreshIndicator(
          onRefresh: () async => vm.getMessages(topic.id),
          child: vm.isLoading
              ? const Center(child: Loading())
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          ...vm.messages.map((e) => messageTile(e)),
                        ],
                      ),
                    ),
                    newMessageTile()
                  ],
                ),
        );
      }),
    );
  }

  Widget messageTile(BlogMsgModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '${dateToString(model.date)} ${hourToStringFromStamp(model.date)}',
              style: const TextStyle(color: Colors.white38),
            ),
          )
        ],
      ),
    );
  }

  Widget newMessageTile() {
    TextEditingController cont = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: cont,
                maxLines: 2,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                vm.sendMessage(cont.text, topic.id);
                cont.clear();
              },
              icon: Icon(
                Icons.send,
                color: Colors.grey.shade900,
              ))
        ],
      ),
    );
  }
}
