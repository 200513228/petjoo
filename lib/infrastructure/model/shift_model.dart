import 'package:flutter/material.dart';
import 'package:petjoo/domain/enums/shift/days.dart';
import '../../domain/entities/shift.dart';

typedef ShiftModelList = List<ShiftModel>;

class ShiftModel extends Shift {
  ShiftModel({required super.day, required super.start, required super.end, required super.isActive});

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    final startList = (json['start'] as String).split(':');
    final endList = (json['end'] as String).split(':');
    return ShiftModel(
      day: Days.values[json['day'] as int],
      start: TimeOfDay(hour: int.parse(startList[0]), minute: int.parse(startList[1])),
      end: TimeOfDay(hour: int.parse(endList[0]), minute: int.parse(endList[1])),
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'day': day.index, 'start': "${start.hour}:${start.minute}", 'end': "${end.hour}:${end.minute}", 'isActive': isActive};
}
