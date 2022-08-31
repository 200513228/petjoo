import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/base/ui_snackbar.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';
import 'package:petjoo/modules/user/service/user_service.dart';
import 'package:petjoo/modules/user/view/register_view.dart';
part 'login_viewmodel.g.dart';

class LoginViewModel = LoginViewModelBase with _$LoginViewModel;

abstract class LoginViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  TextEditingController emailCont = TextEditingController();
  @observable
  TextEditingController passCont = TextEditingController();

  @action
  Future login(BuildContext _) async {
    isLoading = !isLoading;
    UserService.login(emailCont.text, passCont.text)
        .then((value) => value == 'LOGIN' ? succesful(_) : error(_, value));
  }

  @action
  Future forgotPass(BuildContext _) async {
    await UserService.forgotPass(emailCont.text).then(
        (value) => value == 'FORGOT' ? succesfulPass(_) : errorPass(_, value));
  }

  @action
  void succesful(BuildContext _) {
    isLoading = !isLoading;
    Navigator.pushAndRemoveUntil(
        _,
        MaterialPageRoute(builder: (context) => WelcomeView()),
        (route) => false);
  }

  @action
  void succesfulPass(BuildContext _) {
    Navigator.pop(_);
    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar('login_mail_sended'.tr()));
  }

  @action
  void error(BuildContext context, String value) {
    isLoading = !isLoading;
    ScaffoldMessenger.of(context).showSnackBar(uiSnackBar(value));
  }

  @action
  void errorPass(BuildContext context, String value) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(uiSnackBar(value));
  }

  @action
  void createAcc(BuildContext _) {
    Navigator.push(_, MaterialPageRoute(builder: (context) => RegisterView()));
  }
}
