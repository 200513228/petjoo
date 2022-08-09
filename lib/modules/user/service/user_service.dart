import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petjoo/modules/user/model/user_model.dart';

class UserService {
  static var auth = FirebaseAuth.instance;
  static var db = FirebaseFirestore.instance;
  static Future currentUser() async {
    var result = await db.collection('users').doc(auth.currentUser!.uid).get();
    CurrentUser.fromDS(result);
  }

  static Future getUser(String uid) async {
    var result = await db.collection('users').doc(uid).get();
    CurrentUser.fromDS(result);
  }
}
