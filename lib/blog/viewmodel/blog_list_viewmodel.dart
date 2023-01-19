import 'package:mobx/mobx.dart';
part 'blog_list_viewmodel.g.dart';

class BlogListViewModel = BlogListViewModelBase with _$BlogListViewModel;

abstract class BlogListViewModelBase with Store {}
