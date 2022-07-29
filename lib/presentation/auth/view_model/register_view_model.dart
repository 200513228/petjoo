import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/dial_codes.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/models/user_model.dart';
import 'package:petjoo/product/network/requests.dart';
import 'package:petjoo/product/services/notification_service.dart';

class RegisterViewModel extends PageNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ValueNotifier<String> dialCode = ValueNotifier(dialCodes[WidgetsBinding.instance.window.locale.countryCode ?? "TR"] ?? "+90");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegisterViewModel(BuildContext context) : super(context);

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    surnameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() => context.pushReplacementNamed(Routes.login);

  void register() async {
    if (!formKey.currentState!.validate()) return;
    changeLoading();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      if (credential.user == null) throw Exception();

      await Requests.createUser(UserModel(
              id: credential.user!.uid,
              email: emailController.text,
              name: nameController.text,
              surname: surnameController.text,
              phone: phoneController.text,
              dialCode: dialCode.value,
              fcmToken: (await NotificationService.instance.token) ?? ''))
          .then((value) => context.pushNamedAndRemoveUntil(Routes.navigation, predicate: (_) => false));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          context.showSnackBar(context.localization.invalidEmail);
          break;
        case 'weak-password':
          context.showSnackBar(context.localization.weakPassword);
          break;
        case 'email-already-in-use':
          context.showSnackBar(context.localization.emailAlreadyInUse);
          break;
        default:
          context.showSnackBar(context.localization.somethingWentWrong);
          break;
      }
    } catch (e) {
      context.showSnackBar(context.localization.somethingWentWrong);
    }
    changeLoading();
  }
}
