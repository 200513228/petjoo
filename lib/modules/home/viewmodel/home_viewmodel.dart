import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/chat/service/chat_service.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
part 'home_viewmodel.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {
  @observable
  Widget currentPage = Container();

  @observable
  int currentIndex = 1;

  @observable
  int chatCount = 0;

  @action
  void swithPage(Widget page, int x) {
    currentIndex = x;
    currentPage = page;
  }

  @action
  void navigate(BuildContext context, Widget page, bool pop) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => page), (route) => pop);
  }

  @action
  Future getChatCount() async {
    var data = await ChatService.getChats();
    for (var element in data.docs) {
      var lm = element.data()['lastMessage'] as Map<String, dynamic>;
      (lm['senderId'] != CurrentUser.id && lm['isReaded'] == false)
          ? chatCount++
          : null;
    }
  }
}
