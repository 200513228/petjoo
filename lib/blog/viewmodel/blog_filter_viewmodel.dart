import 'package:mobx/mobx.dart';
part 'blog_filter_viewmodel.g.dart';

class BlogFilterViewModel = BlogFilterViewModelBase with _$BlogFilterViewModel;

abstract class BlogFilterViewModelBase with Store {
  @observable
  int? type;
}
