import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/base/ui_snackbar.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
import 'package:petjoo/modules/user/service/user_service.dart';
part 'profile_viewmodel.g.dart';

class ProfileViewModel = ProfileViewModelBase with _$ProfileViewModel;

abstract class ProfileViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  String dialCode = CurrentUser.dialCode != '' ? CurrentUser.dialCode : '+90';
  @observable
  TextEditingController phoneCont =
      TextEditingController(text: CurrentUser.phone);
  @observable
  TextEditingController nameCont =
      TextEditingController(text: CurrentUser.name);
  @observable
  TextEditingController surnameCont =
      TextEditingController(text: CurrentUser.surname);

  @action
  Future save(BuildContext context) async {
    isLoading = !isLoading;
    await UserService.update({
      'name': nameCont.text,
      'surname': surnameCont.text,
      'dialCode': dialCode,
      'phone': phoneCont.text
    }).then((value) =>
        value == 'UPDATE' ? successfull(context) : error(context, value));
  }

  @action
  void error(BuildContext _, String data) {
    isLoading = !isLoading;
    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar(data));
  }

  @action
  void successfull(BuildContext context) {
    isLoading = !isLoading;
    Navigator.pop(context);
  }
}
