import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'emergancy_detail_viewmodel.g.dart';

class EmergancyDetailViewModel = EmergancyDetailViewModelBase
    with _$EmergancyDetailViewModel;

abstract class EmergancyDetailViewModelBase with Store {
  @observable
  int currentPage = 0;

  @observable
  PageController cont = PageController(initialPage: 0);

  @action
  void newPage(int i) {
    currentPage = i;
    cont.animateToPage(currentPage,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }
}
