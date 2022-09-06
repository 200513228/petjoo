import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/transport/model/transport_advert_model.dart';
part 'transport_detail_viewmodel.g.dart';

class TransportDetailViewModel = TransportDetailViewModelBase
    with _$TransportDetailViewModel;

abstract class TransportDetailViewModelBase with Store {
  @observable
  TransportAdvertModel? advert;

  @action
  void setModel(TransportAdvertModel model) {
    advert = model;
  }
}
