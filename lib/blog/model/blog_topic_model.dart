import 'package:cloud_firestore/cloud_firestore.dart';

class BlogTopicModel {
  String id = '';
  String title = '';
  int type = 0;
  String userId = '';
  Timestamp date = Timestamp.fromDate(DateTime.now());

  BlogTopicModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    title = data['title'] ?? '';
    type = data['type'] ?? 0;
    userId = data['userId'] ?? '';
    date = data['date'] ?? Timestamp.fromDate(DateTime.now());
  }
  BlogTopicModel.fromDS(DocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    title = data['title'] ?? '';
    type = data['type'] ?? 0;
    userId = data['userId'] ?? '';
    date = data['date'] ?? Timestamp.fromDate(DateTime.now());
  }
}
