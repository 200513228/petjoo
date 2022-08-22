import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/store/model/store_filter_model.dart';
import 'package:petjoo/modules/store/view/store_list_view.dart';
part 'store_filter_viewmodel.g.dart';

class StoreFilterViewModel = StoreFilterViewModelBase
    with _$StoreFilterViewModel;

abstract class StoreFilterViewModelBase with Store {
  @observable
  int? type;
  @observable
  int? delivery;
  @observable
  int? status;

  @action
  void resetFilter(BuildContext context) {
    StoreListView.vm.resetFilter();
    Navigator.pop(context);
  }

  @action
  void setFilter(BuildContext context) {
    var result = StoreFilterModel.filter(
        advertType: type ?? 0,
        advertStatus: status ?? 0,
        advertDelivery: delivery ?? 0);
    StoreListView.vm.setFilter(result);
    Navigator.pop(context);
  }

  @action
  void setCurrent() {
    type = StoreListView.vm.filter.advertType;
    delivery = StoreListView.vm.filter.advertDelivery;
    status = StoreListView.vm.filter.advertStatus;
  }
}
