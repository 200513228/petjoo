import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/user/model/current_user.dart';

class PetService {
  static var db = FirebaseFirestore.instance;
  static var storage = FirebaseStorage.instance.ref();

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

  static Future<bool> addAdverts(
      PetAdvertModel model, File? img1, File? img2) async {
    try {
      var doc =
          await db.collection('adverts').add(PetAdvertModel.modelToJson(model));
      String? url1;
      String? url2;
      if (img1 != null) {
        var result = storage
            .child('advert_images')
            .child(doc.id)
            .child(DateTime.now().toString());
        await result.putFile(img1);
        url1 = await result.getDownloadURL();
      }
      if (img2 != null) {
        var result = storage
            .child('advert_images')
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

  static Future<List<String?>> getUserInfo(String userId) async {
    var result = await db.collection('users').doc(userId).get();
    var data = result.data() as dynamic;
    String? userName = data['name'] + ' ' + data['surname'];
    String? userImage = data['image'];
    return [userName, userImage];
  }
}
