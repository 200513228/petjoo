import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

class ForgotPasswordViewModel extends PageNotifier {
  ForgotPasswordViewModel(BuildContext context, String email)
      : emailController = TextEditingController(text: email),
        super(context);

  final TextEditingController emailController;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void sendEmail() async {
    final localization = context.localization;
    changeLoading();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
        context.showSnackBar(localization.weSentYouAnEmail);
        context.pop();
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          context.showSnackBar(localization.invalidEmail);
          break;
        case 'user-not-found':
          context.showSnackBar(localization.wrongEmail);
          break;
        default:
          context.showSnackBar(localization.somethingWentWrong);
          break;
      }
    } catch (e) {
      context.showSnackBar(localization.somethingWentWrong);
    }
    changeLoading();
  }
}
