import 'package:mobx/mobx.dart';
import 'package:petjoo/blog/model/blog_topic_model.dart';
import 'package:petjoo/blog/service/blog_service.dart';
import 'package:petjoo/user/model/current_user.dart';
part 'blog_userlist_viewmodel.g.dart';

class BlogUserListViewModel = BlogUserListViewModelBase
    with _$BlogUserListViewModel;

abstract class BlogUserListViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  List<BlogTopicModel> topics = [];
  @action
  Future getTopics() async {
    isLoading = true;
    List<BlogTopicModel> temp = [];
    topics.clear();
    var data = await BlogService.getUserTopics(CurrentUser.id);
    for (var element in data.docs) {
      temp.add(BlogTopicModel.fromQDS(element));
    }
    topics = temp;
    isLoading = false;
  }
}
