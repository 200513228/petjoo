import 'package:mobx/mobx.dart';
import 'package:petjoo/blog/model/blog_msg_model.dart';
import 'package:petjoo/blog/service/blog_service.dart';
part 'blog_detail_viewmodel.g.dart';

class BlogDetailViewModel = BlogDetailViewModelBase with _$BlogDetailViewModel;

abstract class BlogDetailViewModelBase with Store {
  @observable
  bool isLoading = false;

  @observable
  List<BlogMsgModel> messages = [];

  @action
  Future getMessages(String docid) async {
    isLoading = true;
    List<BlogMsgModel> temp = [];
    messages.clear();
    var data = await BlogService.getMessages(docid);
    for (var element in data.docs) {
      temp.add(BlogMsgModel.fromQDS(element));
    }
    messages = temp;
    isLoading = false;
  }
}
