import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/models/user_model.dart';
import 'package:petjoo/product/network/requests.dart';
import 'package:petjoo/product/providers/user_provider.dart';
import 'package:petjoo/product/ui/dialogs/delete_dialog.dart';

class ProfileViewModel extends PageNotifier {
  ProfileViewModel(BuildContext context, this._userProvider) : super(context);

  final UserProvider _userProvider;
  late final UserModel user = _userProvider.user.copy();
  late final TextEditingController nameController = TextEditingController(text: user.name);
  late final TextEditingController surnameController = TextEditingController(text: user.surname);
  late final TextEditingController phoneController = TextEditingController(text: user.phone);
  late final ValueNotifier<String> dialCode = ValueNotifier(user.dialCode);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void save() {
    if (!formKey.currentState!.validate()) return;
    changeLoading();

    user.name = nameController.text;
    user.surname = surnameController.text;
    user.phone = phoneController.text;
    user.dialCode = dialCode.value;
    Requests.updateUser(user).then((value) => context.pop(), onError: (_) {
      context.showSnackBar(context.localization.somethingWentWrong);
      changeLoading();
    });
  }
}
