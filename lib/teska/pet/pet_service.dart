import 'package:cloud_firestore/cloud_firestore.dart';

class PetService {
  static var db = FirebaseFirestore.instance;
  static Future<QuerySnapshot<Map<String, dynamic>>> advertRequest() async {
    return db
        .collection('adverts')
        .orderBy('date', descending: true)
        .limit(3)
        .get();
  }
}
