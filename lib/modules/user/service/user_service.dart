import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petjoo/modules/user/model/current_user.dart';

class UserService {
  static var auth = FirebaseAuth.instance;
  static var db = FirebaseFirestore.instance;
  static var storage = FirebaseStorage.instance.ref();

  static Future<String?> get token =>
      FirebaseMessaging.instance.getToken().onError((error, stackTrace) => "");

  static Future currentUser() async {
    var result = await db.collection('users').doc(auth.currentUser!.uid).get();
    CurrentUser.fromDS(result);
  }

  static Future<String> login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'fcmToken': await token});
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

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String userId) async {
    return await db.collection('users').doc(userId).get();
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

  static Future<String> profilePic(File? img) async {
    try {
      String? url;
      var result = storage.child('user_images').child(CurrentUser.id);
      if (img != null) {
        await result.putFile(img);
        url = await result.getDownloadURL();
        await db
            .collection('users')
            .doc(auth.currentUser!.uid)
            .update({'image': url});
      }
      return 'PIC';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future<String> deleteAccount() async {
    try {
      await auth.currentUser!.delete();
      await logout();
      return 'DELETE';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future<String> forgotPass(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return 'FORGOT';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future logout() async {
    await auth.signOut();
    CurrentUser.clear();
  }
}
