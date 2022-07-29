import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

enum Animals {
  none,
  other,
  dog,
  cat,
  bird,
  aquarium,
  rodent;

  IconData toIconData() {
    switch (this) {
      case Animals.dog:
        return FontAwesomeIcons.dog;
      case Animals.cat:
        return FontAwesomeIcons.cat;
      case Animals.bird:
        return FontAwesomeIcons.kiwiBird;
      case Animals.aquarium:
        return FontAwesomeIcons.fish;
      case Animals.rodent:
        return FontAwesomeIcons.bug;
      case Animals.other:
        return Icons.more_horiz_rounded;
      default:
        return Icons.more_horiz_rounded;
    }
  }

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case Animals.dog:
        return localization.dog;
      case Animals.cat:
        return localization.cat;
      case Animals.bird:
        return localization.bird;
      case Animals.aquarium:
        return localization.aquarium;
      case Animals.rodent:
        return localization.rodent;
      case Animals.other:
        return localization.other;
      default:
        return localization.all;
    }
  }
}
