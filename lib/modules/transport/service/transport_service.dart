import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petjoo/modules/transport/model/transport_advert_model.dart';
import 'package:petjoo/modules/user/model/current_user.dart';

class TransportService {
  static var db = FirebaseFirestore.instance;
  static var storage = FirebaseStorage.instance.ref();

  static Future<QuerySnapshot<Map<String, dynamic>>> getAdverts() async {
    var result = db
        .collection('transport_adverts')
        .where('isActive', isEqualTo: true)
        .get();
    return result;
  }

  static Future<String> updateAdvert(
      TransportAdvertModel model, File? img1, File? img2) async {
    try {
      var doc = db.collection('transport_adverts').doc(model.id);
      await doc.update(TransportAdvertModel.modelToJson(model));
      String? url1;
      String? url2;
      if (img1 != null) {
        var result = storage
            .child('transport_advert_images')
            .child(doc.id)
            .child(DateTime.now().toString());
        await result.putFile(img1);
        url1 = await result.getDownloadURL();
      }
      if (img2 != null) {
        var result = storage
            .child('transport_advert_images')
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

  static Future<String> changeVisible(String docid, bool isActive) async {
    try {
      await db
          .collection('transport_adverts')
          .doc(docid)
          .update({'isActive': isActive});
      return 'ACTIVE';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> userAdvert() async {
    var result =
        await db.collection('transport_adverts').doc(CurrentUser.id).get();
    if (result.exists) {
      return result;
    } else {
      await createAdvert();
      var created =
          await db.collection('transport_adverts').doc(CurrentUser.id).get();
      return created;
    }
  }

  static Future<String> createAdvert() async {
    await db.collection('transport_adverts').doc(CurrentUser.id).set({
      'isActive': false,
      'foundedDate': Timestamp.now(),
      'title': CurrentUser.name,
    });
    return 'CREATE';
  }

  // static Future deleteAdvert() async {
  //   try {
  //     await db.collection('transport_adverts').doc(CurrentUser.id).delete();
  //   } on Exception catch (e) {
  //     log(e.toString());
  //   }
  // }
}
