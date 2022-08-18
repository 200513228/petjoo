import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/service/pet_service.dart';
part 'pet_detail_viewmodel.g.dart';

class PetDetailViewModel = PetDetailViewModelBase with _$PetDetailViewModel;

abstract class PetDetailViewModelBase with Store {
  @observable
  PetAdvertModel? advert;
  @observable
  String? userImage;
  @observable
  String? userName;

  @action
  Future userInfo(String uid) async {
    var data = await PetService.getUserInfo(uid);
    userName = data[0];
    userImage = data[1];
  }

  @action
  void setModel(PetAdvertModel model) {
    advert = model;
  }

  @action
  void call() {}
}
