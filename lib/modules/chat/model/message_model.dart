import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/modules/user/model/current_user.dart';

class MessageModel {
  String id = '';
  String content = '';
  String senderId = '';
  Timestamp date = Timestamp.now();
  bool isReaded = true;

  MessageModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    content = data['content'] ?? '';
    senderId = data['senderId'] ?? '';
    isReaded = data['isReaded'] ?? true;
    date = data['date'] ?? Timestamp.now();
  }

  MessageModel.fromMap(Map map) {
    id = map['id'] ?? '';
    content = map['content'] ?? '';
    senderId = map['senderId'] ?? '';
    isReaded = map['isReaded'] ?? false;
    date = map['date'] ?? Timestamp.now();
  }

  static Map<String, dynamic> toMap(String content) {
    return {
      'content': content,
      'senderId': CurrentUser.id,
      'isReaded': false,
      'date': Timestamp.now(),
    };
  }
}
