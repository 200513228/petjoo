import 'package:flutter/material.dart';

class TipTextButton extends StatelessWidget {
  final Widget tip;
  final Widget text;
  final Function()? onTap;
  const TipTextButton({Key? key, required this.tip, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      DefaultTextStyle(style: theme.textTheme.caption?.copyWith(fontSize: 14) ?? const TextStyle(), child: tip),
      TextButton(
        onPressed: onTap,
        child: text,
      )
    ]);
  }
}