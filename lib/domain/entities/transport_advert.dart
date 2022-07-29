import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/domain/entities/shift.dart';

typedef TransportAdvertList = List<TransportAdvert>;

abstract class TransportAdvert {
  String? id; //Same as userId Because every user can has only one transportAdvert
  List<String> images;
  String title;
  String description;
  String dialCode;
  String phone;
  String address;
  double pricePerKm;
  int vehicleCapacity;
  bool isIntercity;
  bool hasCage;
  bool hasCollar;
  bool canCatch;
  bool isActive;
  DateTime foundedDate;
  GeoPoint? geoPoint;
  List<Shift> shifts;
  final DocumentSnapshot<Map<String, dynamic>>? document;

  TransportAdvert(
      {required this.id,
      required List<String>? images,
      required this.title,
      required this.description,
      required this.dialCode,
      required this.phone,
      required this.address,
      required this.pricePerKm,
      required this.vehicleCapacity,
      required this.isIntercity,
      required this.hasCage,
      required this.hasCollar,
      required this.canCatch,
      required this.isActive,
      required this.foundedDate,
      required this.geoPoint,
      required this.shifts,
      required this.document})
      : images = images ?? [];
}
