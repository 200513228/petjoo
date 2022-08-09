import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';
part 'home_viewmodel.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {
  @observable
  Widget currentPage = Container();

  @action
  void swithPage(Widget page) {
    currentPage = page;
  }

  @action
  void navigate(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
        (route) => page.toString() == WelcomeView().toString() ? false : true);
  }
}
