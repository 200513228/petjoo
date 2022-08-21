import 'package:mobx/mobx.dart';
part 'pet_filter_viewmodel.g.dart';

class PetFilterViewModel = PetFilterViewModelBase with _$PetFilterViewModel;

abstract class PetFilterViewModelBase with Store {
  @observable
  int? type;
  @observable
  int? delivery;
  @observable
  int? status;

  @action
  void resetFilter() {}
  @action
  void setFilter() {}
}
