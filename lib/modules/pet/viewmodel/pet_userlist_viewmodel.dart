import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
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
}
