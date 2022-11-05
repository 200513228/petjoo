import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PleaseAccess extends StatelessWidget {
  const PleaseAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('access_title'.tr()),
      content: Text('access_content'.tr()),
    );
  }
}
