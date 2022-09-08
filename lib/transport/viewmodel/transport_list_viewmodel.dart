import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/transport/service/transport_service.dart';
part 'transport_list_viewmodel.g.dart';

class TransportListViewModel = TransportListViewModelBase
    with _$TransportListViewModel;

abstract class TransportListViewModelBase with Store {
  @observable
  List<TransportAdvertModel> advertList = [];
  @observable
  TextEditingController cont = TextEditingController();

  @action
  Future getAdverts() async {
    List<TransportAdvertModel> temp = [];
    var data = await TransportService.getAdverts();
    for (var element in data.docs) {
      temp.add(TransportAdvertModel.fromQDS(element));
    }
    advertList = temp;
  }
}
