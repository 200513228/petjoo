import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UnderMaintenance extends StatelessWidget {
  const UnderMaintenance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('under_maintenance'.tr()),
      content: Text('under_maintenance_content'.tr()),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('close'.tr())),
      ],
    );
  }
}
