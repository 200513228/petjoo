import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/transport/model/transport_filter_model.dart';
import 'package:petjoo/transport/service/transport_service.dart';
part 'transport_list_viewmodel.g.dart';

class TransportListViewModel = TransportListViewModelBase
    with _$TransportListViewModel;

abstract class TransportListViewModelBase with Store {
  @observable
  List<TransportAdvertModel> advertList = [];
  @observable
  List<TransportAdvertModel> recoveryList = [];
  @observable
  TransportFilterModel filter = TransportFilterModel.filter(
      hasIntercity: 0, hasCage: 0, hasCollar: 0, hasCatch: 0, is24: 0);
  @observable
  bool? sortStatus;
  @observable
  TextEditingController cont = TextEditingController();

  @action
  Future getAdverts() async {
    List<TransportAdvertModel> temp = [];
    var data = await TransportService.getAdverts();
    for (var element in data.docs) {
      temp.add(TransportAdvertModel.fromQDS(element));
    }
    advertList = temp;
    recoveryList = temp;
  }

  @action
  void sort(bool? sort) {
    List<TransportAdvertModel> temp = recoveryList;
    sortStatus = sort;
    if (sort == true) {
      temp.sort((b, a) => a.pricePerKm.compareTo(b.pricePerKm));
      advertList = temp;
    } else if (sort == false) {
      temp.sort((a, b) => a.pricePerKm.compareTo(b.pricePerKm));
      advertList = temp;
    } else {
      advertList = recoveryList;
    }
  }

  @action
  void query(String query) {
    List<TransportAdvertModel> temp = recoveryList;
    if (query == '') {
      advertList = recoveryList;
    } else {
      advertList = temp
          .where((element) =>
              ('${element.title.toLowerCase()} ${element.description.toLowerCase()} ${element.address}')
                  .contains(query.toLowerCase()))
          .toList();
    }
  }

  @action
  void resetFilter() {
    filter = TransportFilterModel.filter(
        hasIntercity: 0, hasCage: 0, hasCollar: 0, hasCatch: 0, is24: 0);
    advertList = recoveryList;
  }

  @action
  void setFilter(TransportFilterModel model) {
    filter = model;
    List<TransportAdvertModel> temp = recoveryList;
    advertList = temp
        .where((element) =>
            filter.hasIntercity == (element.isIntercity ? 1 : 2) ||
            filter.hasIntercity == 0)
        .where((element) =>
            filter.hasCage == (element.hasCage ? 1 : 2) || filter.hasCage == 0)
        .where((element) =>
            filter.hasCatch == (element.canCatch ? 1 : 2) ||
            filter.hasCatch == 0)
        .where((element) =>
            filter.hasCollar == (element.hasCollar ? 1 : 2) ||
            filter.hasCollar == 0)
        .where((element) =>
            filter.is24 == (element.is24 ? 1 : 2) || filter.is24 == 0)
        .toList();
  }
}
