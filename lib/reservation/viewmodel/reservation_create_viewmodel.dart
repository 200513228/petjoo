import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/location/service/location_picker.dart';
import 'package:petjoo/location/service/location_service.dart';
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
  GlobalKey<FormState> formKey = GlobalKey();
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
  Future<String> save(BuildContext context) async {
    if (beginGeoPoint != null &&
        endGeoPoint != null &&
        formKey.currentState!.validate()) {
      isLoading = !isLoading;
      model!.id = '${CurrentUser.id}_${advertModel!.id}_${DateTime.now()}}';
      model!.advertId = advertModel!.id;
      model!.userId = CurrentUser.id;
      model!.fullName = nameCont.text;
      model!.animalType = animal ?? 0;
      model!.description = descCont.text;
      model!.dialCode = dialCode ?? '+90';
      model!.phone = phoneCont.text;
      model!.beginGeoPoint = beginGeoPoint!;
      model!.endGeoPoint = endGeoPoint!;
      model!.distanceA = 0.0;
      model!.distanceB = 0.0;
      model!.resPricePerKm = advertModel!.pricePerKm;
      model!.status = 0;
      model!.distanceA = await LocationService.getDirections(
          origin: advertModel!.geoPoint, destination: beginGeoPoint!);
      model!.distanceB = await LocationService.getDirections(
          origin: beginGeoPoint!, destination: endGeoPoint!);
      isLoading = !isLoading;
      return 'SHOW';
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(uiSnackBar('reservation_create_fill'.tr()));
      return '';
    }
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

  @action
  Future calculateAndSave(BuildContext context) async {
    await ReservationService.createReservation(model!).then((value) =>
        value == 'CREATE' ? successfull(context) : error(context, value));
  }
}
