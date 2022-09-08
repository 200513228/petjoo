import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/modules/reservation/model/reservation_model.dart';

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
}
