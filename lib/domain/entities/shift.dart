import 'package:flutter/material.dart';

import '../enums/shift/days.dart';

abstract class Shift {
  final Days day;
  TimeOfDay start;
  TimeOfDay end;
  bool isActive;

  Shift({required this.day, required this.start, required this.end, required this.isActive});
}
