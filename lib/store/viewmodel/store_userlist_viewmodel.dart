import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/store/model/store_advert_model.dart';
import 'package:petjoo/store/service/store_service.dart';
import 'package:petjoo/store/view/store_add_view.dart';
import 'package:petjoo/store/view/store_detail_view.dart';
part 'store_userlist_viewmodel.g.dart';

class StoreUserListViewModel = StoreUserListViewModelBase
    with _$StoreUserListViewModel;

abstract class StoreUserListViewModelBase with Store {
  @observable
  List<StoreAdvertModel> advertList = [];

  @action
  Future getUserAdverts() async {
    List<StoreAdvertModel> temp = [];
    var data = await StoreService.getAdverts(isUser: true);
    for (var element in data.docs) {
      temp.add(StoreAdvertModel.fromQDS(element));
    }
    advertList = temp;
    advertList.sort((b, a) =>
        a.date.microsecondsSinceEpoch.compareTo(b.date.microsecondsSinceEpoch));
  }

  @action
  Future newAdvert(BuildContext _) async {
    Navigator.push(
        _, MaterialPageRoute(builder: (context) => StoreAddView(model: null)));
  }

  @action
  void pickAdvert(StoreAdvertModel model, BuildContext _) {
    Navigator.push(
        _, MaterialPageRoute(builder: (_) => StoreDetailView(model: model)));
  }
}
