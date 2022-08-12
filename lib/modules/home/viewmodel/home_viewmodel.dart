import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
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
  void navigate(BuildContext context, Widget page, bool pop) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => page), (route) => pop);
  }
}
