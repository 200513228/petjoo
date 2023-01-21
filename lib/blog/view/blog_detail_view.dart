import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
      appBar: AppBar(title: Text(topic.title)),
      body: Observer(builder: (context) {
        return RefreshIndicator(
          onRefresh: () async => vm.getMessages(topic.id),
          child: vm.isLoading
              ? const Center(child: Loading())
              : ListView(
                  children: [...vm.messages.map((e) => messageTile(e))],
                ),
        );
      }),
    );
  }

  Widget messageTile(BlogMsgModel model) {
    return Text(
      model.message,
      style: const TextStyle(color: Colors.black, fontSize: 18),
    );
  }

  Widget newMessageTile() {
    TextEditingController cont = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: cont,
          ),
        )
      ],
    );
  }
}
