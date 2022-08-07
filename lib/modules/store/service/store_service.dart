import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';

class StoreService {
  static var db = FirebaseFirestore.instance;
  static var storage = FirebaseStorage.instance.ref();

  static Future<QuerySnapshot<Map<String, dynamic>>> getAdverts() async {
    return db
        .collection('store_adverts')
        // .where('isSold', isEqualTo: true)
        .orderBy('date', descending: true)
        .limit(3)
        .get();
  }

  static Future<bool> addAdverts(
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
      await db.collection('store_adverts').doc(doc.id).update({
        'images': [
          if (img1 != null) url1!,
          if (img2 != null) url2!,
        ]
      });
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUserAdverts(
      String userId) async {
    return db
        .collection('store_adverts')
        .where('userId', isEqualTo: userId)
        .get();
  }
}
