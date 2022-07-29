import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/network/requests.dart';

class ExtraViewModel extends PageNotifier {
  ExtraViewModel(BuildContext context) : super(context);

  void profile() => context.pushNamed(Routes.profile);
  void settings() => context.pushNamed(Routes.settings);

  void signOut() {
    Requests.removeUserFcm(FirebaseAuth.instance.currentUser!.uid);
    FirebaseAuth.instance.signOut();
    context.pushReplacementNamed(Routes.auth);
  }
}
