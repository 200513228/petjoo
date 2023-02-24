import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/user/model/current_user.dart';
part 'reservation_e_add_viewmodel.g.dart';

class ReservationEAddViewModel = ReservationEAddViewModelBase
    with _$ReservationEAddViewModel;

abstract class ReservationEAddViewModelBase with Store {
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
}
