import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/model/chat_advert_model.dart';
import 'package:petjoo/home/service/dlink_service.dart';
import 'package:petjoo/home/service/report_service.dart';
import 'package:petjoo/reservation/view/reservation_shift_view.dart';
import 'package:petjoo/ui/please_auth.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/chat/service/chat_service.dart';
import 'package:petjoo/chat/view/chat_detail_view.dart';
import 'package:petjoo/home/view/home_view.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/transport/service/transport_service.dart';
import 'package:petjoo/transport/view/transport_create_view.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
part 'transport_detail_viewmodel.g.dart';

class TransportDetailViewModel = TransportDetailViewModelBase
    with _$TransportDetailViewModel;

abstract class TransportDetailViewModelBase with Store {
  @observable
  TransportAdvertModel? advert;

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
  Future publish(BuildContext context) async {
    Uri link = await DLinkService.createTransportLink(advert!.id);
    Share.share(link.toString());
  }

  @action
  Future report(BuildContext context) async {
    if (CurrentUser.id == '') {
      showDialog(context: context, builder: (context) => const PleaseAuth());
    } else {
      await ReportService.sendReport({
        'date': Timestamp.now(),
        'doc': advert!.id,
        'col': 'transport_adverts',
        'userId': CurrentUser.id,
        'status': false,
      }).then((value) => value == 'REPORT'
          ? ScaffoldMessenger.of(context)
              .showSnackBar(uiSnackBar('Rapor başarıyla gönderildi.'))
          : ScaffoldMessenger.of(context).showSnackBar(
              uiSnackBar('Rapor gönderilirken bir hata oluştu.')));
    }
  }

  @action
  Future message(BuildContext _) async {
    await ChatService.goToChat(advert!.id).then((value) => Navigator.push(
          _,
          MaterialPageRoute(
            builder: (builder) => ChatDetailView(
              model: value,
              name: advert!.title,
              advertModel:
                  ChatAdvertModel.fromManuel(advert!.id, 'transport_adverts'),
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
        MaterialPageRoute(builder: (context) => HomeView(title: 'PET NAKİL')),
        (route) => false);
  }
}
