import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_advert_model.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/chat/service/chat_service.dart';
import 'package:petjoo/chat/view/chat_detail_view.dart';
import 'package:petjoo/home/service/dlink_service.dart';
import 'package:petjoo/home/view/home_view.dart';
import 'package:petjoo/pet/model/pet_advert_model.dart';
import 'package:petjoo/pet/service/pet_service.dart';
import 'package:petjoo/pet/view/pet_add_view.dart';
import 'package:petjoo/user/service/user_service.dart';
import 'package:share_plus/share_plus.dart';
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
  Future publish(BuildContext context) async {
    Uri link = await DLinkService.createPetLink(advert!.id);
    Share.share(link.toString());
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
    await ChatService.goToChat(advert!.userId).then((value) => Navigator.push(
          _,
          MaterialPageRoute(
            builder: (builder) => ChatDetailView(
              model: value,
              name: advert!.title,
              advertModel: ChatAdvertModel.fromManuel(advert!.id, 'adverts'),
            ),
          ),
        ));
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
