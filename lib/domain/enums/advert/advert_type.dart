import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

enum AdvertType {
  none,
  emergency,
  lost,
  baby,
  handicapped,
  temporaryHome,
  permanentHome,
  fosterMother;

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case AdvertType.baby:
        return localization.baby;
      case AdvertType.emergency:
        return localization.emergency;
      case AdvertType.fosterMother:
        return localization.fosterMother;
      case AdvertType.handicapped:
        return localization.unimpeded;
      case AdvertType.lost:
        return localization.lost;
      case AdvertType.temporaryHome:
        return localization.temporaryHome;
      case AdvertType.permanentHome:
        return localization.permanentHome;
      default:
        return localization.all;
    }
  }

  Color toColor() {
    switch (this) {
      case AdvertType.baby:
        return Colors.orangeAccent;
      case AdvertType.emergency:
        return Colors.redAccent;
      case AdvertType.fosterMother:
        return Colors.orangeAccent;
      case AdvertType.handicapped:
        return Colors.blueAccent;
      case AdvertType.lost:
        return Colors.redAccent;
      case AdvertType.temporaryHome:
        return Colors.orangeAccent;
      case AdvertType.permanentHome:
        return Colors.orangeAccent;
      default:
        return Colors.redAccent;
    }
  }
}
