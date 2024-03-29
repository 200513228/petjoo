import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/user/model/current_user.dart';

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
  int status = 0;
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
    status = data['status'] ?? 0;
    isSold = data['isSold'] ?? true;
  }

  StoreAdvertModel.fromDS(DocumentSnapshot<Map<String, dynamic>> snapshot) {
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
    status = data['status'] ?? 0;
    isSold = data['isSold'] ?? true;
  }

  StoreAdvertModel.empty() {
    id = '';
    title = '';
    description = '';
    price = 0;
    userId = '';
    dialCode = '';
    phone = '';
    address = '';
    images = [];
    date = Timestamp.now();
    geoPoint = const GeoPoint(0, 0);
    type = 0;
    delivery = 0;
    status = 0;
    isSold = false;
  }

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
      'type': model.type,
      'delivery': model.delivery,
      'status': model.status,
      'isSold': false,
      'geoPoint': model.geoPoint
    };
  }
}
