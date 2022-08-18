import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/view/pet_add_view.dart';
part 'pet_userlist_viewmodel.g.dart';

class PetUserListViewModel = PetUserListViewModelBase
    with _$PetUserListViewModel;

abstract class PetUserListViewModelBase with Store {
  @observable
  List<PetAdvertModel> advertList = [];

  @action
  Future getAdverts() async {}

  @action
  void selectAdvert() {}

  @action
  void newAdvert(BuildContext _) {
    Navigator.push(
        _, MaterialPageRoute(builder: (context) => PetAddView(model: null)));
  }
}
