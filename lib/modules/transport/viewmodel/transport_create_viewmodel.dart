import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/transport/model/transport_advert_model.dart';
import 'package:petjoo/modules/transport/service/transport_service.dart';
import 'package:petjoo/modules/transport/view/transport_hours_view.dart';
import 'package:petjoo/modules/transport/view/transport_picture_view.dart';
part 'transport_create_viewmodel.g.dart';

class TransportCreateViewModel = TransportCreateViewModelBase
    with _$TransportCreateViewModel;

abstract class TransportCreateViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  TransportAdvertModel? advert;
  @observable
  GlobalKey<FormState> formKey = GlobalKey();
  @observable
  TextEditingController titleCont = TextEditingController();
  @observable
  TextEditingController descCont = TextEditingController();
  @observable
  TextEditingController addressCont = TextEditingController();
  @observable
  TextEditingController priceCont = TextEditingController();
  @observable
  bool canCatch = false;
  @observable
  bool isIntercity = false;
  @observable
  bool hasCollar = false;
  @observable
  bool hasCage = false;

  @action
  Future setAdvert() async {
    isLoading = !isLoading;
    var data = await TransportService.userAdvert();
    advert = TransportAdvertModel.fromDS(data);
    titleCont.text = advert?.title ?? '';
    descCont.text = advert?.description ?? '';
    addressCont.text = advert?.address ?? '';
    priceCont.text = '${advert?.pricePerKm ?? 0.0}';
    canCatch = advert?.canCatch ?? false;
    isIntercity = advert?.isIntercity ?? false;
    hasCollar = advert?.hasCollar ?? false;
    hasCage = advert?.hasCage ?? false;
    isLoading = !isLoading;
  }

  @action
  void editHours(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransportHoursView(
                  shiftList: advert!.shifts,
                )));
  }

  @action
  Future nextStep(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      advert!.title = titleCont.text;
      advert!.description = descCont.text;
      advert!.address = addressCont.text;
      advert!.pricePerKm = double.parse(priceCont.text);
      advert!.canCatch = canCatch;
      advert!.isIntercity = isIntercity;
      advert!.hasCage = hasCage;
      advert!.hasCollar = hasCollar;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => TransportPictureView(model: advert!)));
    }
  }
}
