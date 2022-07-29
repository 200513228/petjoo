import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

enum Days {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case Days.monday:
        return localization.monday;
      case Days.tuesday:
        return localization.tuesday;
      case Days.wednesday:
        return localization.wednesday;
      case Days.thursday:
        return localization.thursday;
      case Days.friday:
        return localization.friday;
      case Days.saturday:
        return localization.saturday;
      case Days.sunday:
        return localization.sunday;
      default:
        return '';
    }
  }
}
