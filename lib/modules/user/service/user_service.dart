import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:petjoo/modules/user/model/current_user.dart';

class UserService {
  static var auth = FirebaseAuth.instance;
  static var db = FirebaseFirestore.instance;

  static Future<String?> get token =>
      FirebaseMessaging.instance.getToken().onError((error, stackTrace) => "");

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

  static Future<String> register(
      String email, String pass, Map<String, dynamic> map) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pass);

      await db.collection('users').doc(auth.currentUser!.uid).set(map);
      var result =
          await db.collection('users').doc(auth.currentUser!.uid).get();
      CurrentUser.fromDS(result);
      return 'REGISTER';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  static Future<String> update(Map<String, dynamic> map) async {
    try {
      await db.collection('users').doc(auth.currentUser!.uid).update(map);
      var result =
          await db.collection('users').doc(auth.currentUser!.uid).get();
      CurrentUser.fromDS(result);
      return 'UPDATE';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future logout() async {
    await auth.signOut();
    CurrentUser.clear();
  }
}
