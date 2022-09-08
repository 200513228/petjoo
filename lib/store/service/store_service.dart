import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petjoo/store/model/store_advert_model.dart';
import 'package:petjoo/user/model/current_user.dart';

class StoreService {
  static var db = FirebaseFirestore.instance;
  static var storage = FirebaseStorage.instance.ref();

  static Future<QuerySnapshot<Map<String, dynamic>>> getAdverts(
      {required bool isUser}) async {
    return isUser
        ? db
            .collection('store_adverts')
            .where('userId', isEqualTo: CurrentUser.id)
            .get()
        : db
            .collection('store_adverts')
            .where('isSold', isEqualTo: false)
            .get();
  }

  static Future<String> addAdverts(
      StoreAdvertModel model, File? img1, File? img2) async {
    try {
      var doc = await db
          .collection('store_adverts')
          .add(StoreAdvertModel.modelToJson(model));
      String? url1;
      String? url2;
      if (img1 != null) {
        var result = storage
            .child('store_advert_images')
            .child(doc.id)
            .child(DateTime.now().toString());
        await result.putFile(img1);
        url1 = await result.getDownloadURL();
      }
      if (img2 != null) {
        var result = storage
            .child('store_advert_images')
            .child(doc.id)
            .child(DateTime.now().toString());
        await result.putFile(img2);
        url2 = await result.getDownloadURL();
      }
      await doc.update({
        'images': [
          if (img1 != null) url1!,
          if (img2 != null) url2!,
        ]
      });
      return 'ADD';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future<String> updateAdvert(
      StoreAdvertModel model, File? img1, File? img2) async {
    try {
      var doc = db.collection('store_adverts').doc(model.id);
      await doc.update(StoreAdvertModel.modelToJson(model));
      String? url1;
      String? url2;
      if (img1 != null) {
        var result = storage
            .child('store_advert_images')
            .child(doc.id)
            .child(DateTime.now().toString());
        await result.putFile(img1);
        url1 = await result.getDownloadURL();
      }
      if (img2 != null) {
        var result = storage
            .child('store_advert_images')
            .child(doc.id)
            .child(DateTime.now().toString());
        await result.putFile(img2);
        url2 = await result.getDownloadURL();
      }
      await doc.update({
        'images': [
          if (img1 != null) url1!,
          if (img2 != null) url2!,
        ]
      });
      return 'UPDATE';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future<String> changeSold(String docid, bool isSold) async {
    try {
      await db
          .collection('store_adverts')
          .doc(docid)
          .update({'isSold': isSold});
      return 'SOLD';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future<String> deleteAdvert(String docid) async {
    try {
      await db.collection('store_adverts').doc(docid).delete();
      return 'DELETE';
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
