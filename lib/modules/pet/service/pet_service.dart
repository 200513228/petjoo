import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/modules/user/model/user_model.dart';

class PetService {
  static var db = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getAdverts(
      {required bool isUser}) async {
    return isUser
        ? db
            .collection('adverts')
            .where('userId', isEqualTo: CurrentUser.id)
            .limit(5)
            .get()
        : db
            .collection('adverts')
            .where('isAdopted', isNotEqualTo: true)
            .limit(5)
            .get();
  }
}
