import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/chat/model/chat_model.dart';
import 'package:petjoo/modules/chat/service/chat_service.dart';
import 'package:petjoo/modules/chat/view/chat_detail_view.dart';
part 'chat_tile_viewmodel.g.dart';

class ChatTileViewModel = ChatTileViewModelBase with _$ChatTileViewModel;

abstract class ChatTileViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  String image = '';
  @observable
  String name = '';

  @action
  Future getUserInfo(String userId) async {
    isLoading = !isLoading;
    var result = await ChatService.getUserInfo(userId);
    var data = result.data() as dynamic;
    name = data['name'] + ' ' + data['surname'];
    image = data['image'];
    isLoading = !isLoading;
  }

  @action
  void openChat(BuildContext context, ChatModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChatDetailView(model: model, name: name)));
  }

  @action
  void readChat(String doc) {}
}
