import 'package:cloud_firestore/cloud_firestore.dart';

class StoreAdvertModel {
  String id = '';
  String title = '';
  String description = '';
  String userId = '';
  String dialCode = '';
  String phone = '';
  List images = [];
  Timestamp date = Timestamp.now();
  GeoPoint geoPoint = const GeoPoint(0, 0);
  int type = 0;
  bool isSold = true;

  StoreAdvertModel.fromQDS(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    title = data['title'] ?? '';
    description = data['description'] ?? '';
    userId = data['userId'] ?? '';
    dialCode = data['dialCode'] ?? '';
    phone = data['phone'] ?? '';
    images = data['images'] ?? [];
    date = data['date'] ?? Timestamp.now();
    geoPoint = data['geoPoint'] ?? const GeoPoint(0, 0);
    type = data['type'] ?? 0;
    isSold = data['isSold'] ?? true;
  }

  StoreAdvertModel.fromManuel({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.dialCode,
    required this.phone,
    required this.images,
    required this.date,
    required this.geoPoint,
    required this.type,
    required this.isSold,
  });
}
