import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/chat/service/chat_service.dart';
import 'package:petjoo/chat/view/chat_detail_view.dart';
import 'package:petjoo/home/view/home_view.dart';
import 'package:petjoo/location/view/location_show_view.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/reservation/service/reservation_service.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:petjoo/user/service/user_service.dart';
import 'package:url_launcher/url_launcher.dart';
part 'reservation_detail_viewmodel.g.dart';

class ReservationDetailViewModel = ReservationDetailViewModelBase
    with _$ReservationDetailViewModel;

abstract class ReservationDetailViewModelBase with Store {
  @observable
  ReservationModel? model;
  @observable
  String userImage = '';
  @observable
  String? userName;
  @observable
  String? companyPhone;
  @observable
  bool isLoading = false;

  @action
  void setModels(ReservationModel xmodel) {
    model = xmodel;
  }

  @action
  Future userInfo(String uid) async {
    isLoading = !isLoading;
    var result = await UserService.getUserInfo(uid);
    var data = result.data() as dynamic;
    userName = data['name'] + ' ' + data['surname'];
    userImage = data['image'] ?? '';
    companyPhone = data['dialCode'] + data['phone'];
    isLoading = !isLoading;
  }

  @action
  Future call() async {
    Uri url = CurrentUser.id == model!.advertId
        ? Uri(scheme: 'tel', path: '${model!.dialCode}${model!.phone}')
        : Uri(scheme: 'tel', path: '$companyPhone');
    await launchUrl(url);
  }

  @action
  Future message(BuildContext _) async {
    await ChatService.goToChat(
            CurrentUser.id == model!.advertId ? model!.userId : model!.advertId)
        .then((value) => Navigator.push(
              _,
              MaterialPageRoute(
                builder: (builder) => ChatDetailView(
                  model: value,
                  name: userName!,
                  // advertModel: ChatAdvertModel.fromManuel(advert!.id, 'adverts'),
                ),
              ),
            ));
  }

  @action
  Future updateRes(BuildContext _, int status) async {
    await ReservationService.updateReservation(_, model!.id, status)
        .then((value) => value == 'UPDATE' ? successfull(_) : error(_, value));
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

  @action
  void showLocation(BuildContext context, GeoPoint geoPoint) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationShowView(point: geoPoint)));
  }
}
