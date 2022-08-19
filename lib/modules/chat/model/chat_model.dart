import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/modules/chat/model/message_model.dart';

class ChatModel {
  String id = '';
  late MessageModel lastMessage;
  List userIds = [];

  ChatModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    userIds = data['userIds'] ?? [];
    lastMessage = MessageModel.fromMap(data['lastMessage'] ?? {});
  }
}
