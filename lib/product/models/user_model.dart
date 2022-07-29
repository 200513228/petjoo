import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/product/models/user_basic_model.dart';

class UserModel {
  String id;
  String email;
  String image;
  String name;
  String surname;
  String dialCode;
  String phone;
  String fcmToken;
  bool hasTransport;
  bool hasVeterinary;

  UserModel(
      {this.id = "",
      required this.email,
      this.image = "",
      this.name = "",
      this.surname = "",
      this.dialCode = "",
      this.phone = "",
      this.hasTransport = false,
      this.hasVeterinary = false,
      this.fcmToken = ""});

  String get fullname => "$name $surname";

  UserModel copy() => UserModel(
        id: id,
        email: email,
        image: image,
        name: name,
        surname: surname,
        dialCode: dialCode,
        phone: phone,
        fcmToken: fcmToken,
      );

  UserBasicModel get toBasicModel => UserBasicModel(
        id: id,
        name: name,
        surname: surname,
        image: image,
      );

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data()!;
    return UserModel(
      id: snapshot.id,
      email: json['email'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      surname: json['surname'] as String,
      dialCode: json['dialCode'] as String? ?? "+90",
      phone: json['phone'] as String,
      fcmToken: json['fcmToken'] as String,
      hasTransport: json['hasTransport'] as bool? ?? false,
      hasVeterinary: json['hasVeterinary'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "email": email,
        "name": name,
        "image": image,
        "surname": surname,
        "dialCode": dialCode,
        "phone": phone,
        "fcmToken": fcmToken,
        "hasTransport": hasTransport,
        "hasVeterinary": hasVeterinary,
      };
}
