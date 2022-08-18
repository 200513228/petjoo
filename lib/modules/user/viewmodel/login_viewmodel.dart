import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
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
        .then((value) => value == 'LOGIN' ? succesful(_) : error(value));
  }

  @action
  void succesful(BuildContext _) {
    Navigator.pushAndRemoveUntil(
        _,
        MaterialPageRoute(builder: (context) => WelcomeView()),
        (route) => false);
  }

  @action
  void error(String value) {
    isLoading = !isLoading;
  }

  @action
  void createAcc(BuildContext _) {
    Navigator.push(_, MaterialPageRoute(builder: (context) => RegisterView()));
  }
}
