import 'package:flutter/material.dart';

extension NumExtension on num {
  BorderRadius toBorderRadius() => BorderRadius.circular(toDouble());
  BorderRadius toTopBorderRadius() =>
      BorderRadius.vertical(top: Radius.circular(toDouble()));
  BorderRadius toBottomBorderRadius() =>
      BorderRadius.vertical(bottom: Radius.circular(toDouble()));
  BorderRadius toLeftBorderRadius() =>
      BorderRadius.horizontal(left: Radius.circular(toDouble()));
  BorderRadius toRightBorderRadius() =>
      BorderRadius.horizontal(right: Radius.circular(toDouble()));
}
