import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/modules/user/model/current_user.dart';

class PetService {
  static var db = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getAdverts(
      {required bool isUser}) async {
    return isUser
        ? db
            .collection('adverts')
            .where('userId', isEqualTo: CurrentUser.id)
            // .limit(5)
            .get()
        : db
            .collection('adverts')
            .where('isAdopted', isNotEqualTo: true)
            .limit(5)
            .get();
  }

  static Future<List<String?>> getUserInfo(String userId) async {
    var result = await db.collection('users').doc(userId).get();
    var data = result.data() as dynamic;
    String? userName = data['name'] + ' ' + data['surname'];
    String? userImage = data['image'];
    return [userName, userImage];
  }
}
