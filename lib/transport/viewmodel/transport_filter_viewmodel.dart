import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/transport/model/transport_filter_model.dart';
import 'package:petjoo/transport/view/transport_list_view.dart';
part 'transport_filter_viewmodel.g.dart';

class TransportFilterViewModel = TransportFilterViewModelBase
    with _$TransportFilterViewModel;

abstract class TransportFilterViewModelBase with Store {
  @observable
  int? hasIntercity;
  @observable
  int? hasCage;
  @observable
  int? hasCollar;
  @observable
  int? hasCatch;
  @action
  void resetFilter(BuildContext context) {
    TransportListView.vm.resetFilter();
    Navigator.pop(context);
  }

  @action
  void setFilter(BuildContext context) {
    var result = TransportFilterModel.filter(
        hasIntercity: hasIntercity ?? 0,
        hasCollar: hasCollar ?? 0,
        hasCatch: hasCatch ?? 0,
        hasCage: hasCage ?? 0);
    TransportListView.vm.setFilter(result);
    Navigator.pop(context);
  }

  @action
  void setCurrent() {
    hasIntercity = TransportListView.vm.filter.hasIntercity;
    hasCage = TransportListView.vm.filter.hasCage;
    hasCatch = TransportListView.vm.filter.hasCatch;
    hasCollar = TransportListView.vm.filter.hasCollar;
  }
}
