import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/service/store_service.dart';
import 'package:petjoo/modules/store/view/store_detail_view.dart';
part 'store_list_viewmodel.g.dart';

class StoreListViewModel = StoreListViewModelBase with _$StoreListViewModel;

abstract class StoreListViewModelBase with Store {
  @observable
  List<StoreAdvertModel> advertList = [];

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
  }

  @action
  void pickAdvert(StoreAdvertModel model, BuildContext _) {
    Navigator.push(
        _, MaterialPageRoute(builder: (_) => StoreDetailView(model: model)));
  }
}
