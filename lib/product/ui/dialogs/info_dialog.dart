import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/product/constants/dimens.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String description;
  const InfoDialog({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ButtonX(
          width: context.mediaQuery.size.width * .4,
          color: context.theme.colorScheme.primary,
          borderRadius: Dimens.paddingSmall.toBorderRadius(),
          onTap: () {
            context.pop();
          },
          child: Text(context.localization.ok, style: TextStyle(color: context.theme.colorScheme.onPrimary),),
        )
      ],
    );
  }
}
