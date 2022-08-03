import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/service/store_service.dart';
import 'package:petjoo/modules/user/user_service.dart';
part 'store_userlist_viewmodel.g.dart';

class StoreUserListViewModel = StoreUserListViewModelBase
    with _$StoreUserListViewModel;

abstract class StoreUserListViewModelBase with Store {
  @observable
  List<StoreAdvertModel> advertList = [];

  @action
  Future getUserAdverts() async {
    List<StoreAdvertModel> temp = [];
    var data = await StoreService.getUserAdverts(UserService.userid);
    for (var element in data.docs) {
      temp.add(StoreAdvertModel.fromQDS(element));
    }
    advertList = temp;
  }
}
