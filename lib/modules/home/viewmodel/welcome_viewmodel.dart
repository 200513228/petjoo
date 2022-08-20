import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/user/service/user_service.dart';
part 'welcome_viewmodel.g.dart';

class WelcomeViewModel = WelcomeViewModelBase with _$WelcomeViewModel;

abstract class WelcomeViewModelBase with Store {
  @observable
  bool userLog = false;

  @observable
  bool isLoading = false;

  @action
  Future userLogin() async {
    if (UserService.auth.currentUser != null) {
      isLoading = !isLoading;
      await UserService.currentUser();
      userLog = !userLog;
      isLoading = !isLoading;
    }
  }

  @action
  void goModule(BuildContext _, String title) {
    Navigator.push(
        _, MaterialPageRoute(builder: (context) => HomeView(title: title)));
  }
}
