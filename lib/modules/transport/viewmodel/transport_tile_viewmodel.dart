import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/transport/model/transport_advert_model.dart';
import 'package:petjoo/modules/transport/view/transport_detail_view.dart';
part 'transport_tile_viewmodel.g.dart';

class TransportTileViewModel = TransportTileViewModelBase
    with _$TransportTileViewModel;

abstract class TransportTileViewModelBase with Store {
  @action
  void selectAdvert(TransportAdvertModel model, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransportDetailView(model: model)));
  }
}
