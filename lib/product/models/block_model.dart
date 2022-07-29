import 'package:cloud_firestore/cloud_firestore.dart';

class BlockModel {
  String id;
  List<String> users;

  BlockModel({this.id = "", this.users = const []});

  factory BlockModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data()!;
    return BlockModel(
      id: snapshot.id,
      users: (json['users'] as List).cast(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "users": users,
      };
}
