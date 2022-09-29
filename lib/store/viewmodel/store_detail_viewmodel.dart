import 'dart:io';

import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_advert_model.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/chat/service/chat_service.dart';
import 'package:petjoo/chat/view/chat_detail_view.dart';
import 'package:petjoo/home/service/dlink_service.dart';
import 'package:petjoo/home/view/home_view.dart';
import 'package:petjoo/store/model/store_advert_model.dart';
import 'package:petjoo/store/service/store_service.dart';
import 'package:petjoo/store/view/store_add_view.dart';
import 'package:petjoo/user/service/user_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
part 'store_detail_viewmodel.g.dart';

class StoreDetailViewModel = StoreDetailViewModelBase
    with _$StoreDetailViewModel;

abstract class StoreDetailViewModelBase with Store {
  @observable
  StoreAdvertModel? advert;
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
  void showLocation() {
    double lat = advert!.geoPoint.latitude;
    double lng = advert!.geoPoint.longitude;
    if (Platform.isIOS) {
      MapLauncher.showMarker(
          mapType: MapType.apple,
          coords: Coords(lat, lng),
          title: advert!.title);
    } else if (Platform.isAndroid) {
      MapLauncher.showMarker(
          mapType: MapType.google,
          coords: Coords(lat, lng),
          title: advert!.title);
    }
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
  Future publish(BuildContext context) async {
    Uri link = await DLinkService.createStoreLink(advert!.id);
    Share.share(link.toString());
  }

  @action
  Future changeSold(bool isSold, BuildContext _) async {
    StoreService.changeSold(advert!.id, isSold)
        .then((value) => value == 'SOLD' ? successfull(_) : error(_, value));
  }

  @action
  Future delete(BuildContext _) async {
    StoreService.deleteAdvert(advert!.id)
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
              name: userName ?? '',
              advertModel:
                  ChatAdvertModel.fromManuel(advert!.id, 'store_adverts'),
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
        MaterialPageRoute(builder: (context) => HomeView(title: 'PAZAR')),
        (route) => false);
  }
}
