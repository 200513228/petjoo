import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? id;
  final String content;
  final String senderId;
  final DateTime date;
  final bool isReaded;
  final DocumentSnapshot<Map<String, dynamic>>? document;

  MessageModel({this.id, required this.content, required this.date, required this.senderId, this.isReaded = false}): document = null;
  MessageModel._withDocument({this.id, required this.content, required this.date, required this.senderId, this.isReaded = false, this.document});

  factory MessageModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data()!;
    return MessageModel._withDocument(
      id: snapshot.id,
      senderId: json['senderId'] as String,
      content: json['content'] as String,
      date: (json['date'] as Timestamp).toDate(),
      isReaded: json['isReaded'] as bool? ?? true,
      document: snapshot
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderId: json['senderId'] as String,
      content: json['content'] as String,
      date: (json['date'] as Timestamp).toDate(),
      isReaded: json['isReaded'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "senderId": senderId,
        "content": content,
        'date': Timestamp.fromDate(date),
        'isReaded': isReaded,
      };
}