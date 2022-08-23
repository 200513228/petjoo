import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';
import 'package:petjoo/modules/user/service/user_service.dart';
part 'settings_viewmode.g.dart';

class SettingsViewModel = SettingsViewModelBase with _$SettingsViewModel;

abstract class SettingsViewModelBase with Store {
  @action
  Future logout(BuildContext _) async {
    UserService.logout().then((value) => Navigator.pushAndRemoveUntil(
        _,
        MaterialPageRoute(builder: (context) => WelcomeView()),
        (route) => false));
  }

  @action
  void navigate(BuildContext _, Widget page) {
    Navigator.push(_, MaterialPageRoute(builder: (context) => page));
  }
}
