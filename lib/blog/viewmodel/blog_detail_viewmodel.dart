import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/blog/model/blog_msg_model.dart';
import 'package:petjoo/blog/service/blog_service.dart';
import 'package:petjoo/user/model/current_user.dart';
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

  @action
  Future sendMessage(String message, String docid) async {
    Map<String, dynamic> data = {
      'message': message,
      'userId': CurrentUser.id,
      'date': Timestamp.now()
    };
    await BlogService.sendMessage(data, docid)
        .then((value) => value == 'OKAY' ? getMessages(docid) : null);
  }

  @action
  Future deleteTopic(String docid) async {
    await BlogService.deleteBlog(docid);
  }
}
