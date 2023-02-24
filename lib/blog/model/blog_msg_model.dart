import 'package:cloud_firestore/cloud_firestore.dart';

class BlogMsgModel {
  String id = '';
  String message = '';
  String userId = '';
  Timestamp date = Timestamp.fromDate(DateTime.now());

  BlogMsgModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    message = data['message'] ?? '';
    userId = data['userId'] ?? '';
    date = data['date'] ?? Timestamp.fromDate(DateTime.now());
  }
}
