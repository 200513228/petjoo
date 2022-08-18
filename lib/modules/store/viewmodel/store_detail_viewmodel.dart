import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/service/store_service.dart';
import 'package:petjoo/modules/store/view/store_add_view.dart';
import 'package:url_launcher/url_launcher.dart';
part 'store_detail_viewmodel.g.dart';

class StoreDetailViewModel = StoreDetailViewModelBase
    with _$StoreDetailViewModel;

abstract class StoreDetailViewModelBase with Store {
  @observable
  StoreAdvertModel? advert;
  @observable
  String? userImage;
  @observable
  String? userName;

  @action
  Future userInfo(String uid) async {
    var data = await StoreService.getUserInfo(uid);
    userName = data[0];
    userImage = data[1];
  }

  @action
  void setModel(StoreAdvertModel model) {
    advert = model;
  }

  @action
  void editModel(StoreAdvertModel model, BuildContext _) {
    Navigator.push(
        _, MaterialPageRoute(builder: (context) => StoreAddView(model: model)));
  }

  @action
  Future changeSold(bool isSold, BuildContext _) async {
    StoreService.changeSold(advert!.id, isSold)
        .then((value) => value ? successfull(_) : error(_));
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
        MaterialPageRoute(builder: (context) => HomeView(title: 'PAZAR')),
        (route) => false);
  }
}
