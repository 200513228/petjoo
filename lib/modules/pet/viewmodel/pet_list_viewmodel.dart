import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/service/pet_service.dart';
part 'pet_list_viewmodel.g.dart';

class PetListViewModel = PetListViewModelBase with _$PetListViewModel;

abstract class PetListViewModelBase with Store {
  @observable
  List<PetAdvertModel> advertList = [];

  @action
  Future getAdverts() async {
    List<PetAdvertModel> temp = [];
    QuerySnapshot<Map<String, dynamic>> data =
        await PetService.getAdverts(isUser: false);
    for (var element in data.docs) {
      temp.add(PetAdvertModel.fromQDS(element));
    }
    temp.sort((b, a) =>
        a.date.microsecondsSinceEpoch.compareTo(b.date.microsecondsSinceEpoch));
    advertList = temp;
  }
}
