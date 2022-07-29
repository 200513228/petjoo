import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petjoo/product/models/message_model.dart';
import 'package:petjoo/product/models/user_basic_model.dart';

class ChatModel {
  String? id;
  final MessageModel lastMessage;
  final List<String> userIds;
  UserBasicModel? user;
  List<MessageModel> messages;

  ChatModel({this.id, required this.userIds, MessageModel? lastMessage})
      : messages = [],
        lastMessage = lastMessage ?? MessageModel(content: "", date: DateTime.now(), senderId: "");

  bool get isReaded => lastMessage.senderId == FirebaseAuth.instance.currentUser?.uid || lastMessage.isReaded;

  factory ChatModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data()!;
    return ChatModel(
      id: snapshot.id,
      lastMessage: json['lastMessage'] == null ? null : MessageModel.fromJson(json['lastMessage']),
      userIds: (json['userIds'] as List).cast(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userIds': userIds,
      };
}
