import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/modules/chat/model/chat_model.dart';
import 'package:petjoo/modules/chat/service/chat_service.dart';
import 'package:petjoo/modules/chat/view/chat_detail_view.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/reservation/view/reservation_shift_view.dart';
import 'package:petjoo/modules/transport/model/transport_advert_model.dart';
import 'package:petjoo/modules/transport/service/transport_service.dart';
import 'package:petjoo/modules/transport/view/transport_create_view.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
import 'package:url_launcher/url_launcher.dart';
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

  @action
  void makeReservation(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReservationShiftView(model: advert!)));
  }

  @action
  void edit(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const TransportCreateView()));
  }

  @action
  Future changeActive(BuildContext _) async {
    TransportService.changeVisible(advert!.id, !advert!.isActive)
        .then((value) => value == 'ACTIVE' ? successfull(_) : error(_, value));
  }

  @action
  Future call() async {
    Uri url = Uri(scheme: 'tel', path: '${advert!.dialCode}${advert!.phone}');
    await launchUrl(url);
  }

  @action
  Future message(BuildContext _) async {
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

  @action
  void error(BuildContext _, String data) {
    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar(data));
  }

  @action
  void successfull(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView(title: 'PET NAKİL')),
        (route) => false);
  }
}
