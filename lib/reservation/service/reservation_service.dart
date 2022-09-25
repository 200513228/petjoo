import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/user/model/current_user.dart';

class ReservationService {
  static var db = FirebaseFirestore.instance;

  static Future<String> createReservation(ReservationModel model) async {
    try {
      await db
          .collection('transport_reservations')
          .doc(model.id)
          .set(ReservationModel.modelToJson(model));
      return 'CREATE';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future<String> updateReservation(
      BuildContext context, String docid, int status) async {
    try {
      await db
          .collection('transport_reservations')
          .doc(docid)
          .update({'status': status});
      return 'UPDATE';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getReservations(
      Timestamp time, bool transport) async {
    DateTime d = time.toDate();
    DateTime limit = DateTime(d.year, d.month, d.day, 24);
    Timestamp time2 = Timestamp.fromDate(limit);
    return transport
        ? await db
            .collection('transport_reservations')
            .where('advertId', isEqualTo: CurrentUser.id)
            .where('date', isGreaterThanOrEqualTo: time)
            .where('date', isLessThan: time2)
            .get()
        : await db
            .collection('transport_reservations')
            .where('advertId', isNotEqualTo: CurrentUser.id)
            .where('userId', isEqualTo: CurrentUser.id)
            // .orderBy('date', descending: true)
            .get();
  }

  static Future<List> getWeekCounter(DateTime day) async {
    Timestamp time = Timestamp.fromDate(day);
    DateTime d = time.toDate();
    DateTime limit = DateTime(d.year, d.month, d.day, 24);
    Timestamp time2 = Timestamp.fromDate(limit);
    var data = await db
        .collection('transport_reservations')
        .where('advertId', isEqualTo: CurrentUser.id)
        .where('date', isGreaterThanOrEqualTo: time)
        .where('date', isLessThan: time2)
        .get();
    List result = [];
    for (var i = 0; i < data.size; i++) {
      result.add(i);
    }
    return result;
  }
}
