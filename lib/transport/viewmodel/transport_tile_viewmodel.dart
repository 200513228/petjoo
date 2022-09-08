import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_model.dart';
import 'package:petjoo/chat/service/chat_service.dart';
import 'package:petjoo/chat/view/chat_detail_view.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/transport/view/transport_detail_view.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:url_launcher/url_launcher.dart';
part 'transport_tile_viewmodel.g.dart';

class TransportTileViewModel = TransportTileViewModelBase
    with _$TransportTileViewModel;

abstract class TransportTileViewModelBase with Store {
  @observable
  TransportAdvertModel? advert;

  @action
  void setModel(TransportAdvertModel model) {
    advert = model;
  }

  @action
  void selectAdvert(TransportAdvertModel model, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransportDetailView(model: model)));
  }

  @action
  Future call() async {
    Uri url = Uri(scheme: 'tel', path: '${advert!.dialCode}${advert!.phone}');
    await launchUrl(url);
  }

  @action
  Future message(BuildContext _) async {
    // TransportService.delete();
    await ChatService.findChat(advert!.id).then((value) {
      value == null
          ? Navigator.push(
              _,
              MaterialPageRoute(
                  builder: (builder) => ChatDetailView(
                      model: ChatModel.fromUser(CurrentUser.id, advert!.id),
                      name: advert!.title)))
          : openCurrentChat(_, value);
    });
  }

  @action
  Future openCurrentChat(BuildContext _, String id) async {
    await ChatService.getOnes(id).then((value) => Navigator.push(
        _,
        MaterialPageRoute(
            builder: (builder) =>
                ChatDetailView(model: value, name: advert!.title))));
  }
}
