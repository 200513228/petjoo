import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

enum AnimalSize {
  none,
  small,
  medium,
  large;

  IconData toIconData() => Icons.scale_rounded;

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case AnimalSize.small:
        return localization.small;
      case AnimalSize.medium:
        return localization.medium;
      case AnimalSize.large:
        return localization.large;
      default:
        return localization.all;
    }
  }
}
