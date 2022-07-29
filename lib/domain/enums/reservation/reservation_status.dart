import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

enum ReservationStatus {
  waiting,
  denied,
  approved;

  String toLocalizedString(BuildContext context) {
    final localization = context.localization;
    switch (this) {
      case ReservationStatus.waiting:
        return localization.waitingForApproval;
      case ReservationStatus.denied:
        return localization.denied;
      case ReservationStatus.approved:
        return localization.approved;
      default:
        return "";
    }
  }

  Color? toColor() {
    switch (this) {
      case ReservationStatus.approved:
        return Colors.greenAccent;
      case ReservationStatus.denied:
        return Colors.redAccent;
      case ReservationStatus.waiting:
        return Colors.orangeAccent;
      default:
        return null;
    }
  }
}
