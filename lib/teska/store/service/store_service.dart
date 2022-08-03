import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/teska/store/model/store_advert_model.dart';

class StoreService {
  static var db = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getAdverts() async {
    print('gett');
    return db
        .collection('store_adverts')
        // .where('isSold', isEqualTo: true)
        .orderBy('date', descending: true)
        .limit(3)
        .get();
  }

  static Future addAdverts(StoreAdvertModel model) async {
    return db.collection('store_adverts').add({}).then((value) => value.id);
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUserAdverts(
      String userId) async {
    return db
        .collection('store_adverts')
        .where('userId', isEqualTo: userId)
        .get();
  }
}
