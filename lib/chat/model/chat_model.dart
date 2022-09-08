import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/chat/model/message_model.dart';

class ChatModel {
  String id = '';
  MessageModel lastMessage = MessageModel.empty();
  List userIds = [];

  ChatModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    userIds = data['userIds'] ?? [];
    lastMessage = MessageModel.fromMap(data['lastMessage'] ?? {});
  }

  ChatModel.fromDS(DocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    userIds = data['userIds'] ?? [];
    lastMessage = MessageModel.fromMap(data['lastMessage'] ?? {});
  }

  ChatModel.fromUser(String u1, String u2) {
    id = '${u1}_$u2';
    userIds = [u1, u2];
    lastMessage = MessageModel.empty();
  }
}
