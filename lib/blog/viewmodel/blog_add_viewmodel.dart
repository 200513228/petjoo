import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/blog/service/blog_service.dart';
import 'package:petjoo/user/model/current_user.dart';
part 'blog_add_viewmodel.g.dart';

class BlogAddViewModel = BlogAddViewModelBase with _$BlogAddViewModel;

abstract class BlogAddViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  int? type;

  @action
  Future newBlog(String title, String firstMsg) async {
    isLoading = true;
    var result = await BlogService.newBlog({
      'title': title,
      'type': type ?? 0,
      'userId': CurrentUser.id,
      'date': Timestamp.now()
    }, firstMsg);
    isLoading = false;
    return result;
  }
}
