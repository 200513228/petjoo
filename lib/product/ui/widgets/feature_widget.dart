import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/product/constants/dimens.dart';

class FeatureWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final Color? background;
  const FeatureWidget({Key? key, required this.icon, required this.text, this.iconColor, this.background}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        borderRadius: Dimens.radiusSmall.toBorderRadius(),
        color: background ?? theme.colorScheme.onBackground,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: theme.textTheme.caption?.copyWith(fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
