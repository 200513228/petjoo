import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/user/model/user_model.dart';

class StoreService {
  static var db = FirebaseFirestore.instance;
  static var storage = FirebaseStorage.instance.ref();

  static Future<QuerySnapshot<Map<String, dynamic>>> getAdverts(
      {required bool isUser}) async {
    return isUser
        ? db
            .collection('store_adverts')
            .where('userId', isEqualTo: CurrentUser.id)
            .limit(5)
            .get()
        : db
            .collection('store_adverts')
            .where('isSold', isEqualTo: false)
            .limit(5)
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
      await doc.update({
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

  static Future<bool> updateAdvert(StoreAdvertModel model) async {
    try {
      var doc = db.collection('store_adverts').doc(model.id);
      List tempList =
          await doc.get().then((value) => value.data()!['images'] ?? []);
      await doc.update(StoreAdvertModel.modelToJson(model));
      // String? url1;
      // String? url2;
      // if (img1 != null) {
      //   var result = storage
      //       .child('store_advert_images')
      //       .child(doc.id)
      //       .child(DateTime.now().toString());
      //   await result.putFile(img1);
      //   url1 = await result.getDownloadURL();
      // }
      // if (img2 != null) {
      //   var result = storage
      //       .child('store_advert_images')
      //       .child(doc.id)
      //       .child(DateTime.now().toString());
      //   await result.putFile(img2);
      //   url2 = await result.getDownloadURL();
      // }
      // await doc.update({
      //   'images': [
      //     if (img1 != null) url1!,
      //     if (img2 != null) url2!,
      //   ]
      // });
      await doc.update({'images': tempList});
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> changeSold(String docid, bool isSold) async {
    try {
      await db
          .collection('store_adverts')
          .doc(docid)
          .update({'isSold': isSold});
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<List<String?>> getUserInfo(String userId) async {
    var result = await db.collection('users').doc(userId).get();
    var data = result.data() as dynamic;
    String? userName = data['name'] + ' ' + data['surname'];
    String? userImage = data['image'];
    return [userName, userImage];
  }
}
