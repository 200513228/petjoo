import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';
import 'package:petjoo/modules/transport/model/transport_advert_model.dart';
import 'package:petjoo/modules/transport/service/transport_service.dart';
import 'package:petjoo/modules/transport/view/transport_detail_view.dart';
import 'package:petjoo/modules/user/service/user_service.dart';
part 'settings_viewmodel.g.dart';

class SettingsViewModel = SettingsViewModelBase with _$SettingsViewModel;

abstract class SettingsViewModelBase with Store {
  @observable
  bool isLoading = false;

  @action
  Future logout(BuildContext _) async {
    UserService.logout().then((value) => Navigator.pushAndRemoveUntil(
        _,
        MaterialPageRoute(builder: (context) => WelcomeView()),
        (route) => false));
  }

  @action
  void navigate(BuildContext _, Widget page) {
    Navigator.push(_, MaterialPageRoute(builder: (context) => page));
  }

  @action
  Future transportNavigate(BuildContext _) async {
    await TransportService.userAdvert().then((value) => Navigator.push(
        _,
        MaterialPageRoute(
            builder: (context) => TransportDetailView(
                model: TransportAdvertModel.fromDS(value)))));
  }

  @action
  Future profilePic(BuildContext _) async {
    isLoading = !isLoading;
    XFile? tempImage;
    tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (tempImage != null) {
      await UserService.profilePic(File(tempImage.path))
          .then((value) => value == 'PIC' ? successfull(_) : error(_));
    }
  }

  @action
  void error(BuildContext _) {
    isLoading = !isLoading;
    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar('Bir Hata Oluştu'));
  }

  @action
  void successfull(BuildContext context) {
    isLoading = !isLoading;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeView()),
        (route) => false);
  }
}
