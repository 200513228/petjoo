import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationService {
  static var db = FirebaseFirestore.instance;

  static Future<List> getShifts(String advertId) async {
    var result = await db.collection('transport_adverts').doc(advertId).get();
    return result.data()!['shifts'] as List;
  }
}
