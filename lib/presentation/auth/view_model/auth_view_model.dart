import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/routes.dart';

class AuthViewModel extends PageNotifier {
  AuthViewModel(BuildContext context) : super(context);

  void signIn() => context.pushNamed(Routes.login);
  void register() => context.pushNamed(Routes.register);

  void signInAnonymously() {
    changeLoading();

    FirebaseAuth.instance.signInAnonymously().then((value) => context.pushReplacementNamed(Routes.navigation), onError: (_) {
      context.showSnackBar(context.localization.somethingWentWrong);
      changeLoading();
    });
  }
}
