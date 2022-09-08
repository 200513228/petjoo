import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  String id = '';
  String advertId = '';
  String userId = '';
  String dialCode = '';
  String phone = '';
  String description = '';
  GeoPoint beginGeoPoint = const GeoPoint(0, 0);
  GeoPoint endGeoPoint = const GeoPoint(0, 0);
  Timestamp date = Timestamp.now();
  double distance = 0.0;
  double resPricePerKm = 0.0;
  int status = 0;
  int animalType = 0;

  ReservationModel.fromQDS(QueryDocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    advertId = data['advertId'] ?? '';
    userId = data['userId'] ?? '';
    dialCode = data['dialCode'] ?? '';
    phone = data['phone'] ?? '';
    description = data['description'] ?? '';
    beginGeoPoint = data['beginGeoPoint'] ?? const GeoPoint(0, 0);
    endGeoPoint = data['endGeoPoint'] ?? const GeoPoint(0, 0);
    date = data['date'] ?? Timestamp.now();
    distance = data['distance'] ?? 0.0;
    resPricePerKm = data['resPricePerKm'] ?? 0.0;
    status = data['status'] ?? 0;
    animalType = data['animalType'] ?? 0;
  }

  ReservationModel.fromDS(DocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    advertId = data['advertId'] ?? '';
    userId = data['userId'] ?? '';
    dialCode = data['dialCode'] ?? '';
    phone = data['phone'] ?? '';
    description = data['description'] ?? '';
    beginGeoPoint = data['beginGeoPoint'] ?? const GeoPoint(0, 0);
    endGeoPoint = data['endGeoPoint'] ?? const GeoPoint(0, 0);
    date = data['date'] ?? Timestamp.now();
    distance = data['distance'] ?? 0.0;
    resPricePerKm = data['resPricePerKm'] ?? 0.0;
    status = data['status'] ?? 0;
    animalType = data['animalType'] ?? 0;
  }
}
