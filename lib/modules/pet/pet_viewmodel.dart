import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/pet/pet_advert_model.dart';
import 'package:petjoo/modules/pet/pet_service.dart';
part 'pet_viewmodel.g.dart';

class PetViewModel = PetViewModelBase with _$PetViewModel;

abstract class PetViewModelBase with Store {
  @observable
  List<PetAdvertModel> adverts = [];

  @action
  Future getAdverts() async {
    List<PetAdvertModel> tempList = [];
    var data = await PetService.advertRequest();
    for (var element in data.docs) {
      tempList.add(PetAdvertModel.fromQDS(element));
    }
    adverts = tempList;
  }
}
