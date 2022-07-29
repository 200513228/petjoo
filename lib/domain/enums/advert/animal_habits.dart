import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

enum AnimalHabits {
  none,
  caressing,
  docile,
  abstained,
  coward;

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case AnimalHabits.abstained:
        return localization.abstained;
      case AnimalHabits.caressing:
        return localization.caressing;
      case AnimalHabits.coward:
        return localization.coward;
      case AnimalHabits.docile:
        return localization.docile;
      default:
        return localization.all;
    }
  }

  Color? toColor() {
    switch (this) {
      case AnimalHabits.abstained:
        return Colors.grey;
      case AnimalHabits.caressing:
        return Colors.pink;
      case AnimalHabits.coward:
        return Colors.yellow;
      case AnimalHabits.docile:
        return Colors.blue;
      default:
        return null;
    }
  }

  IconData toIconData() => Icons.heart_broken_rounded;
}
