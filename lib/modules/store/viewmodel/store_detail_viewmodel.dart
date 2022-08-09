import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
part 'store_detail_viewmodel.g.dart';

class StoreDetailViewModel = StoreDetailViewModelBase
    with _$StoreDetailViewModel;

abstract class StoreDetailViewModelBase with Store {
  @observable
  StoreAdvertModel? advert;

  @action
  void setModel(StoreAdvertModel model) {
    advert = model;
  }

  @action
  void call() {}
}
