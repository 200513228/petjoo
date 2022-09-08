import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_model.dart';
import 'package:petjoo/chat/service/chat_service.dart';
part 'chat_list_viewmodel.g.dart';

class ChatListViewModel = ChatListViewModelBase with _$ChatListViewModel;

abstract class ChatListViewModelBase with Store {
  @observable
  List<ChatModel> chatList = [];

  @action
  Future getChats() async {
    List<ChatModel> tempList = [];
    var data = await ChatService.getChats();
    for (var element in data.docs) {
      tempList.add(ChatModel.fromQDS(element));
    }
    tempList.sort((b, a) => a.lastMessage.date.microsecondsSinceEpoch
        .compareTo(b.lastMessage.date.microsecondsSinceEpoch));
    chatList = tempList;
  }
}
