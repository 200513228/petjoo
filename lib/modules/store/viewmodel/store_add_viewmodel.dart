import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/base/ui_snackbar.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/service/store_service.dart';
import 'package:petjoo/modules/store/view/store_picture_view.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
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
  bool isLoading = false;

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
  }

  @action
  Future update(BuildContext _) async {
    isLoading = !isLoading;
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
    if (formKey.currentState?.validate() ?? false) {
      StoreService.updateAdvert(advert).then(
          (value) => value == 'UPDATE' ? successfull(_) : error(_, value));
    }
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
