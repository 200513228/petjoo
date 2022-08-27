import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/base/ui_snackbar.dart';
import 'package:petjoo/modules/chat/model/chat_model.dart';
import 'package:petjoo/modules/chat/service/chat_service.dart';
import 'package:petjoo/modules/chat/view/chat_detail_view.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/service/pet_service.dart';
import 'package:petjoo/modules/pet/view/pet_add_view.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
import 'package:petjoo/modules/user/service/user_service.dart';
import 'package:url_launcher/url_launcher.dart';
part 'pet_detail_viewmodel.g.dart';

class PetDetailViewModel = PetDetailViewModelBase with _$PetDetailViewModel;

abstract class PetDetailViewModelBase with Store {
  @observable
  PetAdvertModel? advert;
  @observable
  String userImage = '';
  @observable
  String? userName;
  @observable
  bool isLoading = false;

  @action
  Future userInfo(String uid) async {
    isLoading = !isLoading;
    var result = await UserService.getUserInfo(uid);
    var data = result.data() as dynamic;
    userName = data['name'] + ' ' + data['surname'];
    userImage = data['image'] ?? '';
    isLoading = !isLoading;
  }

  @action
  void setModel(PetAdvertModel model) {
    advert = model;
  }

  @action
  void editModel(PetAdvertModel model, BuildContext _) {
    Navigator.push(
        _, MaterialPageRoute(builder: (context) => PetAddView(model: model)));
  }

  @action
  Future changeAdopt(bool isAdopt, BuildContext _) async {
    PetService.changeAdopt(advert!.id, isAdopt)
        .then((value) => value == 'ADOPT' ? successfull(_) : error(_, value));
  }

  @action
  Future delete(BuildContext _) async {
    PetService.deleteAdvert(advert!.id)
        .then((value) => value == 'DELETE' ? successfull(_) : error(_, value));
  }

  @action
  Future call() async {
    Uri url = Uri(scheme: 'tel', path: '${advert!.dialCode}${advert!.phone}');
    await launchUrl(url);
  }

  @action
  Future message(BuildContext _) async {
    await ChatService.findChat(advert!.userId).then((value) {
      value == null
          ? Navigator.push(
              _,
              MaterialPageRoute(
                  builder: (builder) => ChatDetailView(
                      model: ChatModel.fromUser(CurrentUser.id, advert!.userId),
                      name: userName ?? '')))
          : openCurrentChat(_, value);
    });
  }

  @action
  Future openCurrentChat(BuildContext _, String id) async {
    await ChatService.getOnes(id).then((value) => Navigator.push(
        _,
        MaterialPageRoute(
            builder: (builder) =>
                ChatDetailView(model: value, name: userName ?? ''))));
  }

  @action
  void error(BuildContext _, String data) {
    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar(data));
  }

  @action
  void successfull(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView(title: 'İLANLAR')),
        (route) => false);
  }
}
