import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/modules/user/model/user_model.dart';

class UserService {
  static var db = FirebaseFirestore.instance;
  static Future getUser(String uid) async {
    var result = await db.collection('users').doc(uid).get();
    CurrentUser.fromDS(result);
  }
}
