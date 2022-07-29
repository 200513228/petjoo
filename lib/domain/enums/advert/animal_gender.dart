import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

enum AnimalGender {
  none,
  male,
  female;

  IconData toIconData() {
    switch (this) {
      case AnimalGender.male:
        return Icons.male_rounded;
      case AnimalGender.female:
        return Icons.female_rounded;
      default:
        return Icons.not_interested_rounded;
    }
  }

  Color? toColor() {
    switch (this) {
      case AnimalGender.male:
        return Colors.blueAccent;
      case AnimalGender.female:
        return Colors.pinkAccent;
      default:
        return null;
    }
  }

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case AnimalGender.male:
        return localization.male;
      case AnimalGender.female:
        return localization.female;
      default:
        return localization.all;
    }
  }
}
