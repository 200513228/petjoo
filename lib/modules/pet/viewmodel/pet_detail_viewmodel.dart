import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/service/pet_service.dart';
import 'package:url_launcher/url_launcher.dart';
part 'pet_detail_viewmodel.g.dart';

class PetDetailViewModel = PetDetailViewModelBase with _$PetDetailViewModel;

abstract class PetDetailViewModelBase with Store {
  @observable
  PetAdvertModel? advert;
  @observable
  String? userImage;
  @observable
  String? userName;

  @action
  Future userInfo(String uid) async {
    var data = await PetService.getUserInfo(uid);
    userName = data[0];
    userImage = data[1];
  }

  @action
  void setModel(PetAdvertModel model) {
    advert = model;
  }

  @action
  Future changeAdopt(bool isAdopt, BuildContext _) async {
    // StoreService.changeSold(advert!.id, isSold)
    //     .then((value) => value ? successfull(_) : error(_));
  }

  @action
  Future call() async {
    Uri url = Uri(scheme: 'tel', path: '${advert!.dialCode}${advert!.phone}');
    await launchUrl(url);
  }

  @action
  void error(BuildContext _) {}

  @action
  void successfull(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView(title: 'İLANLAR')),
        (route) => false);
  }
}
