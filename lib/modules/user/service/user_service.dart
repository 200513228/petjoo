import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petjoo/modules/user/model/current_user.dart';

class UserService {
  static var auth = FirebaseAuth.instance;
  static var db = FirebaseFirestore.instance;
  static Future currentUser() async {
    var result = await db.collection('users').doc(auth.currentUser!.uid).get();
    CurrentUser.fromDS(result);
  }

  static Future<String> login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      var result =
          await db.collection('users').doc(auth.currentUser!.uid).get();
      CurrentUser.fromDS(result);
      return 'LOGIN';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  static Future getUser(String uid) async {
    var result = await db.collection('users').doc(uid).get();
    CurrentUser.fromDS(result);
  }

  static Future logout() async {
    await auth.signOut();
    CurrentUser.clear();
  }
}