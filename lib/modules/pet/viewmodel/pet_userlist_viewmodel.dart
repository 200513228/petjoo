import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/service/pet_service.dart';
import 'package:petjoo/modules/pet/view/pet_add_view.dart';
import 'package:petjoo/modules/pet/view/pet_detail_view.dart';
part 'pet_userlist_viewmodel.g.dart';

class PetUserListViewModel = PetUserListViewModelBase
    with _$PetUserListViewModel;

abstract class PetUserListViewModelBase with Store {
  @observable
  List<PetAdvertModel> advertList = [];

  @action
  Future getAdverts() async {
    List<PetAdvertModel> temp = [];
    var data = await PetService.getAdverts(isUser: true);
    for (var element in data.docs) {
      temp.add(PetAdvertModel.fromQDS(element));
    }
    advertList = temp;
    advertList.sort((b, a) =>
        a.date.microsecondsSinceEpoch.compareTo(b.date.microsecondsSinceEpoch));
  }

  @action
  void selectAdvert(BuildContext _, PetAdvertModel model) {
    Navigator.push(
        _, MaterialPageRoute(builder: (_) => PetDetailView(model: model)));
  }

  @action
  void newAdvert(BuildContext _) {
    Navigator.push(
        _, MaterialPageRoute(builder: (context) => PetAddView(model: null)));
  }
}
