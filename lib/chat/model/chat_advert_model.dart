import 'package:cloud_firestore/cloud_firestore.dart';

class ChatAdvertModel {
  String id = '';
  Timestamp date = Timestamp.now();
  String advertId = '';
  String advertCollection = '';

  ChatAdvertModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    advertId = data['advertId'] ?? '';
    advertCollection = data['advertCollection'] ?? '';
    date = data['date'] ?? Timestamp.now();
  }

  ChatAdvertModel.fromManuel(String id, String type) {
    id = id;
    advertId = id;
    advertCollection = type;
    date = Timestamp.now();
  }
}
