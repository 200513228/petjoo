import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/service/store_service.dart';
import 'package:petjoo/modules/store/view/store_add_view.dart';
import 'package:petjoo/modules/store/view/store_detail_view.dart';
import 'package:petjoo/modules/user/model/user_model.dart';
part 'store_userlist_viewmodel.g.dart';

class StoreUserListViewModel = StoreUserListViewModelBase
    with _$StoreUserListViewModel;

abstract class StoreUserListViewModelBase with Store {
  @observable
  List<StoreAdvertModel> advertList = [];

  @action
  Future getUserAdverts() async {
    List<StoreAdvertModel> temp = [];
    var data = await StoreService.getUserAdverts(CurrentUser.id);
    for (var element in data.docs) {
      temp.add(StoreAdvertModel.fromQDS(element));
    }
    advertList = temp;
  }

  @action
  Future newAdvert(BuildContext _) async {
    Navigator.push(_, MaterialPageRoute(builder: (context) => StoreAddView()));
  }

  @action
  Future openAdvert(BuildContext _, StoreAdvertModel model) async {
    Navigator.push(
        _,
        MaterialPageRoute(
            builder: (context) => StoreDetailView(
                  model: model,
                )));
  }
}
