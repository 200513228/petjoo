import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'store_filter_viewmodel.g.dart';

class StoreFilterViewModel = StoreFilterViewModelBase
    with _$StoreFilterViewModel;

abstract class StoreFilterViewModelBase with Store {
  @observable
  TextEditingController cont = TextEditingController();
  @observable
  int? type;
  @observable
  int? delivery;
  @observable
  int? status;

  @action
  void resetFilter() {}
  @action
  void setFilter() {}
}
