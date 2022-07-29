import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'custom_dialog.dart';

class WarningDialog extends StatelessWidget {
  final String title;
  final String description;
  final String? cancelText;
  final String? doneText;
  final Function()? onDoneTap;
  final Function()? onCancelTap;
  const WarningDialog({Key? key, this.onCancelTap, this.onDoneTap, required this.title, required this.description, this.cancelText, this.doneText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final theme = context.theme;
    return CustomDialog(
      title: title,
      description: description,
      leftText: Text(cancelText ?? localization.cancel),
      rightText: Text(doneText ??localization.ok, style: TextStyle(color: theme.colorScheme.onPrimary),),
      leftColor: theme.hintColor,
      rightColor: theme.colorScheme.primary,
      onLeftTap: onCancelTap,
      onRightTap: onDoneTap,
    );
  }
}
