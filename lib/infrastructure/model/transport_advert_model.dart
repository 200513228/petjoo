import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/domain/entities/transport_advert.dart';
import 'package:petjoo/infrastructure/model/shift_model.dart';

typedef TransportAdvertModelList = List<TransportAdvertModel>;

class TransportAdvertModel extends TransportAdvert {
  TransportAdvertModel(
      {super.id,
      super.images,
      required super.title,
      required super.description,
      required super.dialCode,
      required super.phone,
      required super.address,
      required super.pricePerKm,
      required super.vehicleCapacity,
      required super.isIntercity,
      required super.hasCage,
      required super.hasCollar,
      required super.canCatch,
      required super.isActive,
      required super.foundedDate,
      required super.shifts,
      super.geoPoint,
      super.document});

  factory TransportAdvertModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data()!;
    return TransportAdvertModel(
        id: snapshot.id,
        geoPoint: (json['geoPoint'] ?? const GeoPoint(41.01840135294143, 28.97038174246899)) as GeoPoint?,
        images: (json['images'] as List).cast<String>(),
        title: json['title'] as String,
        description: json['description'] as String,
        dialCode: json['dialCode'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        pricePerKm: json['pricePerKm'] as double,
        vehicleCapacity: json['vehicleCapacity'] as int,
        isIntercity: json['isIntercity'] as bool? ?? json['isInternational'] as bool,
        hasCage: json['hasCage'] as bool,
        hasCollar: json['hasCollar'] as bool,
        canCatch: json['canCatch'] as bool,
        isActive: json['isActive'] as bool,
        shifts: (json['shifts'] as List).map((e) => ShiftModel.fromJson(e)).toList(),
        foundedDate: (json['foundedDate'] as Timestamp).toDate(),
        document: snapshot);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'geoPoint': geoPoint,
        'images': images,
        'title': title,
        'description': description,
        'dialCode': dialCode,
        'phone': phone,
        'address': address,
        'pricePerKm': pricePerKm,
        'vehicleCapacity': vehicleCapacity,
        'isIntercity': isIntercity,
        'hasCage': hasCage,
        'hasCollar': hasCollar,
        'canCatch': canCatch,
        'isActive': isActive,
        'shifts': shifts.map((e) => (e as ShiftModel).toJson()).toList(),
        'foundedDate': Timestamp.fromDate(foundedDate),
      };
}
