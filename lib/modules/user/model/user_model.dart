import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUser {
  static String id = '';
  static String image = '';
  static String name = '';
  static String surname = '';
  static String dialCode = '';
  static String phone = '';
  static String email = '';
  static String fcmToken = '';
  static bool hasTransport = false;
  static bool hasVeterinary = false;

  CurrentUser.fromDS(DocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    image = data['image'] ?? '';
    name = data['name'] ?? '';
    surname = data['surname'] ?? '';
    dialCode = data['dialCode'] ?? '';
    phone = data['phone'] ?? '';
    email = data['email'] ?? '';
    fcmToken = data['fcmToken'] ?? '';
    hasTransport = data['hasTransport'] ?? false;
    hasVeterinary = data['hasVeterinary'] ?? false;
  }
}
