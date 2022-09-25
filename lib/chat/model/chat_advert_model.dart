import 'package:cloud_firestore/cloud_firestore.dart';

class ChatAdvertModel {
  String id = '';
  Timestamp date = Timestamp.now();
  String advertId = '';
  String advertCollection =
      ''; //adverts,store_adverts,transport_adverts,transport_reservations

  ChatAdvertModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    advertId = data['advertId'] ?? '';
    advertCollection = data['advertCollection'] ?? '';
    date = data['date'] ?? Timestamp.now();
  }

  ChatAdvertModel.fromManuel(String id, String type) {
    advertId = id;
    advertCollection = type;
    date = Timestamp.now();
  }

  static Map<String, dynamic> toMap(ChatAdvertModel model) {
    return {
      'advertCollection': model.advertCollection,
      'advertId': model.advertId,
      'date': model.date
    };
  }
}
