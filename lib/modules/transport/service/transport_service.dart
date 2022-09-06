import 'package:cloud_firestore/cloud_firestore.dart';

class TransportService {
  static var db = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getAdverts() async {
    var result = db
        .collection('transport_adverts')
        .where('isActive', isEqualTo: true)
        .get();
    return result;
  }
}
