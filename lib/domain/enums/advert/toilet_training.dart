import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

enum ToiletTraining {
  none,
  unknown,
  yes,
  no;

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case ToiletTraining.unknown:
        return localization.unknown;
      case ToiletTraining.yes:
        return localization.hasToiletTraining;
      case ToiletTraining.no:
        return localization.noToiletTraining;
      default:
        return localization.all;
    }
  }

  Color? toColor() {
    switch (this) {
      case ToiletTraining.unknown:
        return Colors.blueGrey;
      case ToiletTraining.yes:
        return Colors.greenAccent;
      case ToiletTraining.no:
        return Colors.redAccent;
      default:
        return null;
    }
  }

  IconData toIconData() => FontAwesomeIcons.toilet;
}
