import 'package:flutter/material.dart';

enum Hours {
  zero(TimeOfDay(hour: 0, minute: 0)),
  zeroHalf(TimeOfDay(hour: 0, minute: 30)),
  one(TimeOfDay(hour: 1, minute: 0)),
  oneHalf(TimeOfDay(hour: 1, minute: 30)),
  two(TimeOfDay(hour: 2, minute: 0)),
  twoHalf(TimeOfDay(hour: 2, minute: 30)),
  three(TimeOfDay(hour: 3, minute: 0)),
  threeHalf(TimeOfDay(hour: 3, minute: 30)),
  four(TimeOfDay(hour: 4, minute: 0)),
  fourHalf(TimeOfDay(hour: 4, minute: 30)),
  five(TimeOfDay(hour: 5, minute: 0)),
  fiveHalf(TimeOfDay(hour: 5, minute: 30)),
  six(TimeOfDay(hour: 6, minute: 0)),
  sixHalf(TimeOfDay(hour: 6, minute: 30)),
  seven(TimeOfDay(hour: 7, minute: 0)),
  sevenHalf(TimeOfDay(hour: 7, minute: 30)),
  eight(TimeOfDay(hour: 8, minute: 0)),
  eightHalf(TimeOfDay(hour: 8, minute: 30)),
  nine(TimeOfDay(hour: 9, minute: 0)),
  nineHalf(TimeOfDay(hour: 9, minute: 30)),
  ten(TimeOfDay(hour: 10, minute: 0)),
  tenHalf(TimeOfDay(hour: 10, minute: 30)),
  eleven(TimeOfDay(hour: 11, minute: 0)),
  elevenHalf(TimeOfDay(hour: 11, minute: 30)),
  twelve(TimeOfDay(hour: 12, minute: 0)),
  twelveHalf(TimeOfDay(hour: 12, minute: 30)),
  thirteen(TimeOfDay(hour: 13, minute: 0)),
  thirteenHalf(TimeOfDay(hour: 13, minute: 30)),
  fourteen(TimeOfDay(hour: 14, minute: 0)),
  fourteenHalf(TimeOfDay(hour: 14, minute: 30)),
  fifteen(TimeOfDay(hour: 15, minute: 0)),
  fifteenHalf(TimeOfDay(hour: 15, minute: 30)),
  sixteen(TimeOfDay(hour: 16, minute: 0)),
  sixteenHalf(TimeOfDay(hour: 16, minute: 30)),
  seventeen(TimeOfDay(hour: 17, minute: 0)),
  seventeenHalf(TimeOfDay(hour: 17, minute: 30)),
  eighteen(TimeOfDay(hour: 18, minute: 0)),
  eighteenHalf(TimeOfDay(hour: 18, minute: 30)),
  nineteen(TimeOfDay(hour: 19, minute: 0)),
  nineteenHalf(TimeOfDay(hour: 19, minute: 30)),
  twenty(TimeOfDay(hour: 20, minute: 0)),
  twentyHalf(TimeOfDay(hour: 20, minute: 30)),
  twentyOne(TimeOfDay(hour: 21, minute: 0)),
  twentyOneHalf(TimeOfDay(hour: 21, minute: 30)),
  twentyTwo(TimeOfDay(hour: 22, minute: 0)),
  twentyTwoHalf(TimeOfDay(hour: 22, minute: 30)),
  twentyThree(TimeOfDay(hour: 23, minute: 0)),
  twentyThreeHalf(TimeOfDay(hour: 23, minute: 30));

  const Hours(this.time);

  final TimeOfDay time;

  String toTimeString(BuildContext context) => time.format(context);
}
