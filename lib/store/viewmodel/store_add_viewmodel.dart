import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/location/service/location_picker.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/home/view/home_view.dart';
import 'package:petjoo/store/model/store_advert_model.dart';
import 'package:petjoo/store/view/store_picture_view.dart';
import 'package:petjoo/user/model/current_user.dart';
part 'store_add_viewmodel.g.dart';

class StoreAddViewModel = StoreAddViewModelBase with _$StoreAddViewModel;

abstract class StoreAddViewModelBase with Store {
  @observable
  StoreAdvertModel advert = StoreAdvertModel.empty();
  @observable
  GlobalKey<FormState> formKey = GlobalKey();
  @observable
  TextEditingController titleCont = TextEditingController();
  @observable
  TextEditingController descCont = TextEditingController();
  @observable
  TextEditingController phoneCont =
      TextEditingController(text: CurrentUser.phone);
  @observable
  TextEditingController priceCont = TextEditingController();
  @observable
  TextEditingController addressCont = TextEditingController();
  @observable
  String? dialCode = CurrentUser.dialCode != '' ? CurrentUser.dialCode : '+90';
  @observable
  num? price;
  @observable
  int? type;
  @observable
  int? delivery;
  @observable
  int? status;
  @observable
  GeoPoint? geoPoint;
  @observable
  bool isLoading = false;

  @action
  Future pickLocation(BuildContext context) async {
    geoPoint = await showLocationPicker(context);
  }

  @action
  void preEdit(StoreAdvertModel model) {
    advert = model;
    titleCont.text = model.title;
    descCont.text = model.description;
    price = model.price;
    priceCont.text = model.price.toString();
    dialCode = model.dialCode == '' ? null : model.dialCode;
    phoneCont.text = model.phone;
    type = model.type;
    delivery = model.delivery;
    status = model.status;
    addressCont.text = model.address;
    geoPoint = model.geoPoint;
  }

  @action
  Future nextStep(BuildContext context) async {
    advert.title = titleCont.text;
    advert.description = descCont.text;
    advert.price = num.tryParse(priceCont.text) ?? 0;
    advert.dialCode = dialCode ?? '';
    advert.phone = phoneCont.text;
    advert.address = addressCont.text;
    advert.type = type ?? 0;
    advert.delivery = delivery ?? 0;
    advert.status = status ?? 0;
    advert.address = addressCont.text;
    advert.geoPoint = geoPoint ?? const GeoPoint(0, 0);
    if (formKey.currentState?.validate() ?? false) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => StorePictureView(model: advert)));
    }
  }

  @action
  void error(BuildContext _, String data) {
    isLoading = !isLoading;
    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar(data));
  }

  @action
  void successfull(BuildContext context) {
    isLoading = !isLoading;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView(title: 'PAZAR')),
        (route) => false);
  }
}
