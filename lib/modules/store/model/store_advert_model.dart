import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/modules/user/model/user_model.dart';

class StoreAdvertModel {
  String id = '';
  String title = '';
  String description = '';
  num price = 0;
  String userId = '';
  String dialCode = '';
  String phone = '';
  String address = '';
  List images = [];
  Timestamp date = Timestamp.now();
  GeoPoint geoPoint = const GeoPoint(0, 0);
  int type = 0;
  int delivery = 0;
  bool isSold = true;

  StoreAdvertModel.fromQDS(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    title = data['title'] ?? '';
    description = data['description'] ?? '';
    price = data['price'] ?? 0;
    userId = data['userId'] ?? '';
    dialCode = data['dialCode'] ?? '';
    phone = data['phone'] ?? '';
    address = data['address'] ?? '';
    images = data['images'] ?? [];
    date = data['date'] ?? Timestamp.now();
    geoPoint = data['geoPoint'] ?? const GeoPoint(0, 0);
    type = data['type'] ?? 0;
    delivery = data['delivery'] ?? 0;
    isSold = data['isSold'] ?? true;
  }

  StoreAdvertModel.fromManuel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.userId,
    required this.dialCode,
    required this.phone,
    required this.address,
    required this.images,
    required this.date,
    required this.geoPoint,
    required this.type,
    required this.delivery,
    required this.isSold,
  });

  static Map<String, dynamic> modelToJson(StoreAdvertModel model) {
    return {
      'title': model.title,
      'description': model.description,
      'price': model.price,
      'userId': CurrentUser.id,
      'dialCode': model.dialCode,
      'phone': model.phone,
      'address': model.address,
      'images': [],
      'date': Timestamp.now(),
      'geoPoint': const GeoPoint(0, 0),
      'type': model.type,
      'delivery': model.delivery,
      'isSold': false,
    };
  }
}
