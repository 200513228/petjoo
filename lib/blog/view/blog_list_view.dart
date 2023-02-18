import 'package:easy_localization/easy_localization.dart';
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
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Scaffold(
        body: Observer(
          builder: (context) {
            return RefreshIndicator(
                onRefresh: () async => vm.getTopics(),
                child: vm.isLoading
                    ? const Center(child: Loading())
                    : ListView(
                        children: [
                          queryText(),
                          ...vm.topics.map((e) => topicCard(e, context))
                        ],
                      ));
          },
        ),
      ),
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

  Widget queryText() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: vm.cont,
              autofocus: false,
              onChanged: (value) {
                vm.query(value);
              },
              decoration: InputDecoration(
                  hintText: 'home_search'.tr(),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
