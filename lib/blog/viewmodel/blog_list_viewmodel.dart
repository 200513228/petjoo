import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/blog/model/blog_filter_model.dart';
import 'package:petjoo/blog/model/blog_topic_model.dart';
import 'package:petjoo/blog/service/blog_service.dart';
part 'blog_list_viewmodel.g.dart';

class BlogListViewModel = BlogListViewModelBase with _$BlogListViewModel;

abstract class BlogListViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  List<BlogTopicModel> topics = [];
  @observable
  List<BlogTopicModel> recoveryList = [];
  @observable
  BlogFilterModel filter = BlogFilterModel.filter(0);
  @observable
  TextEditingController cont = TextEditingController();

  @action
  Future getTopics() async {
    isLoading = true;
    List<BlogTopicModel> temp = [];
    topics.clear();
    var data = await BlogService.getTopics();
    for (var element in data.docs) {
      temp.add(BlogTopicModel.fromQDS(element));
    }
    topics = temp;
    recoveryList = temp;
    isLoading = false;
  }

  @action
  void query(String query) {
    List<BlogTopicModel> temp = recoveryList;
    if (query == '') {
      topics = recoveryList;
    } else {
      topics = temp
          .where((element) =>
              ('${element.title.toLowerCase()} ${element.title.toLowerCase()} ${element.date.toString().toLowerCase()} ')
                  .contains(query.toLowerCase()))
          .toList();
    }
  }

  @action
  void resetFilter() {
    filter = BlogFilterModel.filter(0);
    topics = recoveryList;
  }

  @action
  void setFilter(BlogFilterModel model) {
    filter = model;
    List<BlogTopicModel> temp = recoveryList;
    topics = temp
        .where((element) => filter.type == element.type || filter.type == 0)
        .toList();
  }
}
