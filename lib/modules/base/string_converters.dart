import 'package:cloud_firestore/cloud_firestore.dart';

String dateToString(Timestamp date) {
  var d = date.toDate();
  String day = d.day.toString().length == 1 ? '0${d.day}' : d.day.toString();
  String month =
      d.month.toString().length == 1 ? '0${d.month}' : d.month.toString();
  String year = d.year.toString();
  return '$day.$month.$year';
}

String hourToString(String hour) {
  String start = hour.split(':')[0].length == 1
      ? '0${hour.split(':')[0]}'
      : hour.split(':')[0];
  String end = hour.split(':')[1].length == 1
      ? '${hour.split(':')[1]}0'
      : hour.split(':')[1];
  return '$start:$end';
}

String dayToString(int day) {
  switch (day) {
    case 0:
      return 'Pazartesi';
    case 1:
      return 'Salı';
    case 2:
      return 'Çarşamba';
    case 3:
      return 'Perşembe';
    case 4:
      return 'Cuma';
    case 5:
      return 'Cumartesi';
    case 6:
      return 'Pazar';
    default:
      return 'Pazartesi';
  }
}

extension StringExtension on String {
  bool isNumeric() => double.tryParse(this) != null;
}
