import 'package:cloud_firestore/cloud_firestore.dart';

class TransportAdvertModel {
  String id = '';
  String title = '';
  String description = '';
  String dialCode = '';
  String phone = '';
  String address = '';
  GeoPoint geoPoint = const GeoPoint(0, 0);
  Timestamp foundedDate = Timestamp.now();
  double pricePerKm = 0;
  bool isActive = false;
  bool isIntercity = false;
  bool hasCage = false;
  bool hasCollar = false;
  bool canCatch = false;
  List images = [];
  List shifts = [];

  TransportAdvertModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    title = data['title'] ?? '';
    description = data['description'] ?? '';
    dialCode = data['dialCode'] ?? '';
    phone = data['phone'] ?? '';
    address = data['address'] ?? '';
    geoPoint = data['geoPoint'] ?? const GeoPoint(0, 0);
    foundedDate = data['foundedDate'] ?? Timestamp.now();
    pricePerKm = data['pricePerKm'] ?? 0;
    isActive = data['isActive'] ?? false;
    isIntercity = data['isIntercity'] ?? false;
    hasCage = data['hasCage'] ?? false;
    hasCollar = data['hasCollar'] ?? false;
    canCatch = data['canCatch'] ?? false;
    images = data['images'] ?? false;
    shifts = data['shifts'] ?? false;
  }

  TransportAdvertModel.fromDS(DocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    title = data['title'] ?? '';
    description = data['description'] ?? '';
    dialCode = data['dialCode'] ?? '';
    phone = data['phone'] ?? '';
    address = data['address'] ?? '';
    geoPoint = data['geoPoint'] ?? const GeoPoint(0, 0);
    foundedDate = data['foundedDate'] ?? Timestamp.now();
    pricePerKm = data['pricePerKm'] ?? 0;
    isActive = data['isActive'] ?? false;
    isIntercity = data['isIntercity'] ?? false;
    hasCage = data['hasCage'] ?? false;
    hasCollar = data['hasCollar'] ?? false;
    canCatch = data['canCatch'] ?? false;
    images = data['images'] ?? false;
    shifts = data['shifts'] ?? false;
  }
}
