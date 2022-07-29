import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/domain/enums/advert/animals.dart';
import '../enums/reservation/reservation_status.dart';

typedef TransportReservationList = List<TransportReservation>;

abstract class TransportReservation {
  String? id;
  String userId;
  String fullName;
  String advertId;
  String title;
  String description;
  String dialCode;
  String phone;
  String address;
  String destinationAddress;
  DateTime date;
  Animals animalType;
  ReservationStatus status;
  GeoPoint? beginGeoPoint;
  GeoPoint? endGeoPoint;
  final DocumentSnapshot<Map<String, dynamic>>? document;
  double distance;
  double resPricePerKm;

  TransportReservation({
    required this.id,
    required this.userId,
    required this.advertId,
    required this.fullName,
    required this.title,
    required this.description,
    required this.dialCode,
    required this.phone,
    required this.address,
    required this.destinationAddress,
    required this.date,
    required this.animalType,
    required this.status,
    required this.beginGeoPoint,
    required this.endGeoPoint,
    required this.document,
    required this.distance,
    required this.resPricePerKm,
  });
}
