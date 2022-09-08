import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/user/view/login_view.dart';

class PleaseAuth extends StatelessWidget {
  const PleaseAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('auth_title'.tr()),
      content: Text('auth_content'.tr()),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('close'.tr())),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
            },
            child: Text('auth_title'.tr())),
      ],
    );
  }
}
