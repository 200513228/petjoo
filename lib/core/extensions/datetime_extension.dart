import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:sprintf/sprintf.dart';

extension DateTimeExtension on DateTime {
  String toDateString() => DateFormat("dd.MM.yyyy", "tr").format(this);
  String toTimeString() => DateFormat("HH:mm", "tr").format(this);
  String toDateTimeString() => DateFormat("HH:mm dd.MM.yyyy", "tr").format(this);

  int toAge() => DateTime.now().difference(this).inDays ~/ 365;

  String toDifferenceString(BuildContext context) {
    final localization = context.localization;
    final duration = DateTime.now().difference(this);
    if (duration.inDays.abs() > 6) {
      return DateFormat("dd MMM", "tr").format(this);
    } else if (duration.inDays > 0) {
      return sprintf(localization.daysAgo, [duration.inDays]);
    } else if (duration.inHours > 0) {
      return sprintf(localization.hoursAgo, [duration.inHours]);
    } else if (duration.inMinutes > 0) {
      return sprintf(localization.minutesAgo, [duration.inMinutes]);
    } else {
      return localization.now;
    }
  }

  TimeOfDay toTimeOfDay() => TimeOfDay.fromDateTime(this);
}
