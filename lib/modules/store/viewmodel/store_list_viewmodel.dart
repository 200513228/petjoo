import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/service/store_service.dart';
part 'store_list_viewmodel.g.dart';

class StoreListViewModel = StoreListViewModelBase with _$StoreListViewModel;

abstract class StoreListViewModelBase with Store {
  @observable
  List<StoreAdvertModel> advertList = [];

  @action
  Future getAdverts() async {
    List<StoreAdvertModel> temp = [];
    var data = await StoreService.getAdverts();
    for (var element in data.docs) {
      temp.add(StoreAdvertModel.fromQDS(element));
    }
    advertList = temp;
  }
}
