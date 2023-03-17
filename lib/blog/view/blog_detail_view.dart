import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/string_converters.dart';
import 'package:petjoo/blog/model/blog_msg_model.dart';
import 'package:petjoo/blog/model/blog_topic_model.dart';
import 'package:petjoo/blog/view/blog_list_view.dart';
import 'package:petjoo/blog/viewmodel/blog_detail_viewmodel.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/ui/please_auth.dart';
import 'package:petjoo/user/model/current_user.dart';

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
        actions: [
          PopupMenuButton(
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
              color: Colors.black,
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () => vm.publish(context, topic.id),
                      child: Text(
                        'publish'.tr(),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        if (CurrentUser.id == '') {
                          showDialog(
                              context: context,
                              builder: (context) => const PleaseAuth());
                        } else {
                          vm.report(context, topic.id);
                        }
                      },
                      child: Text(
                        'report'.tr(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    if (topic.userId == CurrentUser.id)
                      PopupMenuItem(
                        onTap: () {
                          vm.deleteTopic(topic.id).then((value) {
                            BlogListView.vm.getTopics();
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          'Konuyu Sil'.tr(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ])
        ],
      ),
      body: Observer(builder: (context) {
        return RefreshIndicator(
          color: Colors.black,
          onRefresh: () async => vm.getMessages(topic.id),
          child: vm.isLoading
              ? const Center(child: Loading())
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          ...vm.messages.map((e) => messageTile(e, context)),
                        ],
                      ),
                    ),
                    if (topic.userId == CurrentUser.id) newMessageTile(false)
                  ],
                ),
        );
      }),
    );
  }

  Widget messageTile(BlogMsgModel model, BuildContext context) {
    return InkWell(
      onTap: () {
        if (topic.userId == CurrentUser.id) {
          showDialog(
              context: (context),
              barrierColor: Colors.black26,
              builder: (diaContext) => updateMessage(diaContext, model));
        }
      },
      child: Container(
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
      ),
    );
  }

  Widget newMessageTile(bool update,
      {String? text, String? msgId, BuildContext? context}) {
    TextEditingController cont = TextEditingController(text: text);
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
                if (update) {
                  vm
                      .updateMessage(cont.text, topic.id, msgId!)
                      .then((value) => Navigator.pop(context!));
                } else {
                  vm.sendMessage(cont.text, topic.id);
                }
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

  Widget updateMessage(BuildContext context, BlogMsgModel message) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          newMessageTile(true,
              text: message.message, msgId: message.id, context: context)
        ],
      ),
    );
  }
}
