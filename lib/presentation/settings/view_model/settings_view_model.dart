import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/routes.dart';

class SettingsViewModel extends PageNotifier {
  SettingsViewModel(BuildContext context) : super(context);

  void appSettings() => context.pushNamed(Routes.appSettings);
  void accountSettings() => context.pushNamed(Routes.accountSettings);
  void termsOfUse() => context.pushNamed(Routes.termsOfUse);
  void privacyPolicy() => context.pushNamed(Routes.privacyPolicy);
  void about() => context.pushNamed(Routes.about);
}
