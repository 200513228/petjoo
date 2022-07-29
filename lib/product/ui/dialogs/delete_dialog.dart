import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/ui/dialogs/custom_dialog.dart';

class DeleteDialog extends StatelessWidget {
  final Function()? onDeleteTap;
  final Function()? onCancelTap;
  const DeleteDialog({Key? key, this.onDeleteTap, this.onCancelTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final theme = context.theme;
    return CustomDialog(
      title: localization.delete,
      description: localization.areYouSureWantToDelete,
      leftText: Text(localization.cancel),
      rightText: Text(localization.delete),
      leftColor: theme.hintColor,
      rightColor: Colors.redAccent,
      onLeftTap: onCancelTap,
      onRightTap: onDeleteTap,
    );
  }
}
