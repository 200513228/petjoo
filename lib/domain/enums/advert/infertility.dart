import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

enum Infertility {
  none,
  unknown,
  yes,
  no;

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case Infertility.unknown:
        return localization.unknown;
      case Infertility.yes:
        return localization.neutered;
      case Infertility.no:
        return localization.unNeutered;
      default:
        return localization.all;
    }
  }

  Color? toColor() {
    switch (this) {
      case Infertility.unknown:
        return Colors.blueGrey;
      case Infertility.yes:
        return Colors.greenAccent;
      case Infertility.no:
        return Colors.redAccent;
      default:
        return null;
    }
  }

  IconData toIconData() => FontAwesomeIcons.neuter;
}
