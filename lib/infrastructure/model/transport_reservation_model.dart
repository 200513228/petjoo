import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/domain/enums/advert/animals.dart';
import '../../domain/entities/transport_reservation.dart';
import '../../domain/enums/reservation/reservation_status.dart';

typedef TransportReservationModelList = List<TransportReservationModel>;

class TransportReservationModel extends TransportReservation {
  TransportReservationModel({
    required super.id,
    required super.userId,
    required super.advertId,
    required super.fullName,
    required super.title,
    required super.description,
    required super.dialCode,
    required super.phone,
    required super.address,
    required super.destinationAddress,
    required super.date,
    required super.animalType,
    required super.status,
    required super.beginGeoPoint,
    required super.endGeoPoint,
    super.document,
    required super.distance,
    required super.resPricePerKm,
  });

  factory TransportReservationModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data()!;
    return TransportReservationModel(
      id: snapshot.id,
      userId: json['userId'] as String,
      advertId: json['advertId'] as String,
      fullName: json['fullName'] as String? ?? "",
      title: json['title'] as String,
      description: json['description'] as String,
      dialCode: json['dialCode'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      destinationAddress: json['destinationAddress'] as String,
      date: (json['date'] as Timestamp).toDate(),
      animalType: Animals.values[json['animalType'] as int],
      status: ReservationStatus.values[json['status'] as int],
      beginGeoPoint: json['beginGeoPoint'] as GeoPoint?,
      endGeoPoint: json['endGeoPoint'] as GeoPoint?,
      document: snapshot,
      distance: (json['distance'] ?? 0.0) as double,
      resPricePerKm: (json['resPricePerKm'] ?? 0.0) as double,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'advertId': advertId,
        'title': title,
        'fullName': fullName,
        'description': description,
        'dialCode': dialCode,
        'phone': phone,
        'address': address,
        'destinationAddress': destinationAddress,
        'date': Timestamp.fromDate(date),
        'animalType': animalType.index,
        'status': status.index,
        'beginGeoPoint': beginGeoPoint,
        'endGeoPoint': endGeoPoint,
        'distance': distance,
        'resPricePerKm': resPricePerKm,
      };
}
