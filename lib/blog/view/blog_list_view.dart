import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/string_converters.dart';
import 'package:petjoo/blog/model/blog_topic_model.dart';
import 'package:petjoo/blog/view/blog_detail_view.dart';
import 'package:petjoo/blog/viewmodel/blog_list_viewmodel.dart';
import 'package:petjoo/ui/loading.dart';

class BlogListView extends StatelessWidget {
  final BlogListViewModel vm = BlogListViewModel();
  BlogListView({super.key});

  @override
  Widget build(BuildContext context) {
    vm.getTopics();
    return Observer(
      builder: (context) {
        return RefreshIndicator(
            onRefresh: () async => vm.getTopics(),
            child: vm.isLoading
                ? const Center(child: Loading())
                : ListView(
                    children: [...vm.topics.map((e) => topicCard(e, context))],
                  ));
      },
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
        subtitle: Text(dateToString(model.date)),
      ),
    );
  }
}
