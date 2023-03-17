import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/string_converters.dart';
import 'package:petjoo/blog/model/blog_topic_model.dart';
import 'package:petjoo/blog/view/blog_add_view.dart';
import 'package:petjoo/blog/view/blog_detail_view.dart';
import 'package:petjoo/blog/viewmodel/blog_userlist_viewmodel.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/ui/please_auth.dart';
import 'package:petjoo/user/model/current_user.dart';

class BlogUserListView extends StatelessWidget {
  final BlogUserListViewModel vm = BlogUserListViewModel();
  BlogUserListView({super.key});

  @override
  Widget build(BuildContext context) {
    vm.getTopics();
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Observer(builder: (context) {
        return vm.isLoading
            ? const Center(child: Loading())
            : RefreshIndicator(
                color: Colors.black,
                onRefresh: () async => vm.getTopics(),
                child: ListView(
                  children: [
                    newTopicCard(context),
                    ...vm.topics.map((e) => topicCard(e, context))
                  ],
                ),
              );
      }),
    );
  }

  Widget topicCard(BlogTopicModel model, BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BlogDetailView(model)));
        },
        style: ListTileStyle.list,
        title: Text(model.title),
        trailing: Text(dateToString(model.date)),
      ),
    );
  }

  Widget newTopicCard(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          if (CurrentUser.id == '') {
            showDialog(
                context: context, builder: (context) => const PleaseAuth());
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BlogAddView()));
          }
        },
        leading: const Icon(Icons.add),
        style: ListTileStyle.list,
        title: const Text('Yeni Blog Başlat'),
      ),
    );
  }
}
