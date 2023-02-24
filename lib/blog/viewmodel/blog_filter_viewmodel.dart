import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/blog/model/blog_filter_model.dart';
import 'package:petjoo/blog/view/blog_list_view.dart';
part 'blog_filter_viewmodel.g.dart';

class BlogFilterViewModel = BlogFilterViewModelBase with _$BlogFilterViewModel;

abstract class BlogFilterViewModelBase with Store {
  @observable
  int? type;

  @action
  void resetFilter(BuildContext context) {
    BlogListView.vm.resetFilter();
    Navigator.pop(context);
  }

  @action
  void setFilter(BuildContext context) {
    var result = BlogFilterModel.filter(type ?? 0);
    BlogListView.vm.setFilter(result);
    Navigator.pop(context);
  }

  @action
  void setCurrent() {
    type = BlogListView.vm.filter.type;
  }
}
