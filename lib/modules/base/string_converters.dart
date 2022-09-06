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
