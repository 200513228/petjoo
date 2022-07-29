import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final Widget leftText;
  final Widget rightText;
  final Color leftColor;
  final Color rightColor;
  final Function()? onLeftTap;
  final Function()? onRightTap;
  const CustomDialog(
      {Key? key,
      this.onLeftTap,
      this.onRightTap,
      required this.title,
      required this.description,
      required this.leftText,
      required this.rightText,
      required this.leftColor,
      required this.rightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        Row(children: [
          Expanded(
              child: ButtonX(
            color: leftColor,
            borderRadius: Dimens.paddingSmall.toBorderRadius(),
            onTap: () {
              context.pop();
              onLeftTap?.call();
            },
            child: leftText,
          )),
          const Separator(),
          Expanded(
              child: ButtonX(
            color: rightColor,
            borderRadius: Dimens.paddingSmall.toBorderRadius(),
            onTap: onRightTap,
            child: rightText,
          ))
        ])
      ],
    );
  }
}
