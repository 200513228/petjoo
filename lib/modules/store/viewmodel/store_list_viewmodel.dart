import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/model/store_filter_model.dart';
import 'package:petjoo/modules/store/service/store_service.dart';
import 'package:petjoo/modules/store/view/store_detail_view.dart';
part 'store_list_viewmodel.g.dart';

class StoreListViewModel = StoreListViewModelBase with _$StoreListViewModel;

abstract class StoreListViewModelBase with Store {
  @observable
  List<StoreAdvertModel> advertList = [];
  @observable
  List<StoreAdvertModel> recoveryList = [];
  @observable
  StoreFilterModel filter = StoreFilterModel.filter(
      advertType: 0, advertStatus: 0, advertDelivery: 0);
  @observable
  TextEditingController cont = TextEditingController();

  @action
  Future getAdverts() async {
    List<StoreAdvertModel> temp = [];
    var data = await StoreService.getAdverts(isUser: false);
    for (var element in data.docs) {
      temp.add(StoreAdvertModel.fromQDS(element));
    }
    temp.sort((b, a) =>
        a.date.microsecondsSinceEpoch.compareTo(b.date.microsecondsSinceEpoch));
    advertList = temp;
    recoveryList = temp;
  }

  @action
  void query(String query) {
    List<StoreAdvertModel> temp = recoveryList;
    if (query == '') {
      advertList = recoveryList;
    } else {
      advertList = temp
          .where((element) =>
              ('${element.title} ${element.description}').contains(query))
          .toList();
    }
  }

  @action
  void resetFilter() {
    filter = StoreFilterModel.filter(
        advertType: 0, advertStatus: 0, advertDelivery: 0);
    advertList = recoveryList;
  }

  @action
  void setFilter(StoreFilterModel model) {
    filter = model;
    List<StoreAdvertModel> temp = recoveryList;
    advertList = temp
        .where((element) =>
            filter.advertType == element.type || filter.advertType == 0)
        .where((element) =>
            filter.advertStatus == element.status || filter.advertStatus == 0)
        .where((element) =>
            filter.advertDelivery == element.delivery ||
            filter.advertDelivery == 0)
        .toList();
  }

  @action
  void pickAdvert(StoreAdvertModel model, BuildContext _) {
    Navigator.push(
        _, MaterialPageRoute(builder: (_) => StoreDetailView(model: model)));
  }
}
