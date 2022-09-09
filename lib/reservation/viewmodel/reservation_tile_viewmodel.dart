import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_model.dart';
import 'package:petjoo/chat/service/chat_service.dart';
import 'package:petjoo/chat/view/chat_detail_view.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/reservation/view/reservation_detail_view.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:petjoo/user/service/user_service.dart';
import 'package:url_launcher/url_launcher.dart';
part 'reservation_tile_viewmodel.g.dart';

class ReservationTileViewModel = ReservationTileViewModelBase
    with _$ReservationTileViewModel;

abstract class ReservationTileViewModelBase with Store {
  @observable
  ReservationModel? model;
  @observable
  bool isLoading = false;
  @observable
  String userImage = '';
  @observable
  String? userName;

  @action
  void setModel(ReservationModel xmodel) {
    model = xmodel;
  }

  @action
  void selectAdvert(ReservationModel xmodel, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReservationDetailView(model: xmodel)));
  }

  @action
  Future call() async {
    Uri url = Uri(scheme: 'tel', path: '${model!.dialCode}${model!.phone}');
    await launchUrl(url);
  }

  @action
  Future message(BuildContext _) async {
    await ChatService.findChat(model!.advertId).then((value) {
      value == null
          ? Navigator.push(
              _,
              MaterialPageRoute(
                  builder: (builder) => ChatDetailView(
                      model: ChatModel.fromUser(CurrentUser.id, model!.userId),
                      name: model!.fullName)))
          : openCurrentChat(_, value);
    });
  }

  @action
  Future openCurrentChat(BuildContext _, String id) async {
    await ChatService.getOnes(id).then((value) => Navigator.push(
        _,
        MaterialPageRoute(
            builder: (builder) =>
                ChatDetailView(model: value, name: model!.fullName))));
  }

  @action
  Future userInfo() async {
    isLoading = !isLoading;
    var result = await UserService.getUserInfo(model!.userId);
    var data = result.data() as dynamic;
    userName = data['name'] + ' ' + data['surname'];
    userImage = data['image'] ?? '';
    isLoading = !isLoading;
  }
}
