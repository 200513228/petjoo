import 'package:mobx/mobx.dart';
import 'package:petjoo/blog/model/blog_topic_model.dart';
import 'package:petjoo/blog/service/blog_service.dart';
part 'blog_list_viewmodel.g.dart';

class BlogListViewModel = BlogListViewModelBase with _$BlogListViewModel;

abstract class BlogListViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  List<BlogTopicModel> topics = [];

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
    isLoading = false;
  }
}
