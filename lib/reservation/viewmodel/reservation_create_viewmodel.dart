import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/location/view/location_picker.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/home/view/home_view.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/reservation/service/reservation_service.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/user/model/current_user.dart';
part 'reservation_create_viewmodel.g.dart';

class ReservationCreateViewModel = ReservationCreateViewModelBase
    with _$ReservationCreateViewModel;

abstract class ReservationCreateViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  ReservationModel? model;
  @observable
  TransportAdvertModel? advertModel;
  @observable
  TextEditingController nameCont = TextEditingController();
  @observable
  TextEditingController descCont = TextEditingController();
  @observable
  TextEditingController phoneCont =
      TextEditingController(text: CurrentUser.phone);
  @observable
  GeoPoint? beginGeoPoint;
  @observable
  GeoPoint? endGeoPoint;
  @observable
  String? dialCode = CurrentUser.dialCode != '' ? CurrentUser.dialCode : '+90';
  @observable
  int? animal;

  @action
  void setModels(ReservationModel xmodel, TransportAdvertModel xadvertModel) {
    model = xmodel;
    advertModel = xadvertModel;
    nameCont.text = xadvertModel.id == CurrentUser.id
        ? ''
        : '${CurrentUser.name} ${CurrentUser.surname}';
  }

  @action
  Future setBegin(BuildContext context) async {
    beginGeoPoint = await showLocationPicker(context);
  }

  @action
  Future setEnd(BuildContext context) async {
    endGeoPoint = await showLocationPicker(context);
  }

  @action
  Future save(BuildContext context) async {
    isLoading = !isLoading;
    model!.id = '${CurrentUser.id}_${advertModel!.id}';
    model!.advertId = advertModel!.id;
    model!.userId = CurrentUser.id;
    model!.fullName = nameCont.text;
    model!.animalType = animal ?? 0;
    model!.description = descCont.text;
    model!.dialCode = dialCode ?? '+90';
    model!.phone = phoneCont.text;
    model!.beginGeoPoint = beginGeoPoint ?? const GeoPoint(0, 0);
    model!.endGeoPoint = endGeoPoint ?? const GeoPoint(0, 0);
    model!.distance = 0.0;
    model!.resPricePerKm = advertModel!.pricePerKm;
    model!.status = 0;
    await ReservationService.createReservation(model!).then((value) =>
        value == 'CREATE' ? successfull(context) : error(context, value));
    isLoading = !isLoading;
  }

  @action
  void error(BuildContext _, String error) {
    isLoading = !isLoading;
    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar(error));
  }

  @action
  void successfull(BuildContext context) {
    isLoading = !isLoading;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView(title: 'PET NAKİL')),
        (route) => false);
  }
}
