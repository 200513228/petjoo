import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_model.dart';
import 'package:petjoo/chat/service/chat_service.dart';
import 'package:petjoo/chat/view/chat_detail_view.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:petjoo/user/service/user_service.dart';
part 'chat_tile_viewmodel.g.dart';

class ChatTileViewModel = ChatTileViewModelBase with _$ChatTileViewModel;

abstract class ChatTileViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  String image = '';
  @observable
  String name = '';
  @observable
  bool isBlocked = false;

  @action
  Future getUserInfo(String userId) async {
    isLoading = !isLoading;
    var result = await UserService.getUserInfo(userId);
    var data = result.data() as dynamic;
    name = '${data['name'] ?? ''} ${data['surname'] ?? ''}';
    image = data['image'] ?? '';
    isLoading = !isLoading;
  }

  @action
  void checkBlock(String userId) {
    isBlocked =
        CurrentUser.blocks.where((element) => element == userId).isNotEmpty;
  }

  @action
  void openChat(BuildContext context, ChatModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChatDetailView(model: model, name: name)));
  }

  @action
  Future readChat(String doc) async {
    await ChatService.readChat(doc);
  }
}
