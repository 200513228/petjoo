import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/providers/user_provider.dart';

import '../../../product/constants/routes.dart';
import '../../../product/network/requests.dart';
import '../../../product/ui/dialogs/delete_dialog.dart';

class AccountSettingsViewModel extends PageNotifier {
  AccountSettingsViewModel(super.context, this._userProvider);

  final UserProvider _userProvider;

  bool get hasTransport => _userProvider.user.hasTransport;

  changeTransport(bool value) {
    Requests.changeUserTransportStatus(_userProvider.user.id, value).then((_) {
      _userProvider.user.hasTransport = value;
      notifyListeners();
    });
  }

  void deleteAccount() => showDialog(
      context: context,
      builder: (context) => DeleteDialog(onDeleteTap: () async {
            changeLoading();
            try {
              FirebaseAuth.instance.currentUser!.delete().then((value) => context.pushNamedAndRemoveUntil(Routes.auth, predicate: (_) => false));
            } catch (e) {
              context.showSnackBar(context.localization.somethingWentWrong);
            }
            changeLoading();
          }));
}
