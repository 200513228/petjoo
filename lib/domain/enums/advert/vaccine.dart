import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

enum Vaccine {
  none,
  unknown,
  yes,
  no;

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case Vaccine.unknown:
        return localization.unknown;
      case Vaccine.yes:
        return localization.vaccinated;
      case Vaccine.no:
        return localization.unVaccinated;
      default:
        return localization.all;
    }
  }

  Color? toColor() {
    switch (this) {
      case Vaccine.unknown:
        return Colors.blueGrey;
      case Vaccine.yes:
        return Colors.greenAccent;
      case Vaccine.no:
        return Colors.redAccent;
      default:
        return null;
    }
  }

  IconData toIconData() => Icons.vaccines_rounded;
}
