import 'package:mobx/mobx.dart';
part 'emergancy_detail_viewmodel.g.dart';

class EmergancyDetailViewModel = EmergancyDetailViewModelBase
    with _$EmergancyDetailViewModel;

abstract class EmergancyDetailViewModelBase with Store {
  @observable
  int currentPage = 0;

  @action
  void newPage(int i) {
    currentPage = i;
  }
}
