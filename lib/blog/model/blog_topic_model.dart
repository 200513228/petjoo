import 'package:cloud_firestore/cloud_firestore.dart';

class BlogTopicModel {
  String id = '';
  String title = '';
  Timestamp date = Timestamp.fromDate(DateTime.now());

  BlogTopicModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    title = snapshot['title'] ?? '';
    date = data['date'] ?? Timestamp.fromDate(DateTime.now());
  }
}
