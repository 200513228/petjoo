import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<QuerySnapshot<Map<String, dynamic>>> getReservations() async {
    return CurrentUser.hasTransport
        ? await db
            .collection('transport_reservations')
            .where('advertId', isEqualTo: CurrentUser.id)
            .get()
        : await db
            .collection('transport_reservations')
            .where('userId', isEqualTo: CurrentUser.id)
            .get();
  }
}
