import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/home/view/document_view.dart';
import 'package:petjoo/home/view/welcome_view.dart';
import 'package:petjoo/user/service/user_service.dart';
part 'register_viewmodel.g.dart';

class RegisterViewModel = RegisterViewModelBase with _$RegisterViewModel;

abstract class RegisterViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  GlobalKey<FormState> formKey = GlobalKey();
  @observable
  TextEditingController emailCont = TextEditingController();
  @observable
  TextEditingController passCont = TextEditingController();
  @observable
  TextEditingController nameCont = TextEditingController();
  @observable
  TextEditingController surNameCont = TextEditingController();
  @observable
  TextEditingController phoneCont = TextEditingController();
  @observable
  String? dialCode = '+90';

  @action
  Future register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = !isLoading;
      await UserService.register(emailCont.text, passCont.text, await usermap())
          .then((value) {
        if (value == 'REGISTER') {
          successfull(context);
        } else {
          error(context, value);
        }
      });
    }
  }

  @action
  void navigate(BuildContext _, String asset) {
    Navigator.push(
        _,
        MaterialPageRoute(
            builder: (context) => DocumentView(assetName: asset)));
  }

  Future<Map<String, dynamic>> usermap() async {
    return {
      'image': '',
      'email': emailCont.text,
      'name': nameCont.text,
      'surname': surNameCont.text,
      'dialCode': dialCode ?? '',
      'phone': phoneCont.text,
      'hasTransport': false,
      'hasVeterinary': false,
      'date': Timestamp.now(),
      'fcmToken': await UserService.token,
    };
  }

  @action
  void successfull(BuildContext context) {
    isLoading = !isLoading;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeView()),
        (route) => false);
  }

  @action
  void error(BuildContext context, String error) {
    isLoading = !isLoading;
    ScaffoldMessenger.of(context).showSnackBar(uiSnackBar(error));
  }
}
