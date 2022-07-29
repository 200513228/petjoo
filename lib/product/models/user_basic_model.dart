import 'package:cloud_firestore/cloud_firestore.dart';

class UserBasicModel {
  String id;
  String image;
  String name;
  String surname;

  UserBasicModel({this.id = "", this.image = "", this.name = "", this.surname = ""});

  String get fullname => "$name $surname";

  factory UserBasicModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data()!;
    return UserBasicModel(
      id: snapshot.id,
      name: json['name'] as String,
      image: json['image'] as String,
      surname: json['surname'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "image": image,
        "surname": surname,
      };
}
