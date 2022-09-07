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
    pricePerKm = data['pricePerKm'] ?? 0.0;
    isActive = data['isActive'] ?? false;
    isIntercity = data['isIntercity'] ?? false;
    hasCage = data['hasCage'] ?? false;
    hasCollar = data['hasCollar'] ?? false;
    canCatch = data['canCatch'] ?? false;
    images = data['images'] ?? [];
    shifts = data['shifts'] ??
        [
          {
            'day': 0,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 1,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 2,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 3,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 4,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 5,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 6,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          }
        ];
    ;
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
    images = data['images'] ?? [];
    shifts = data['shifts'] ??
        [
          {
            'day': 0,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 1,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 2,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 3,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 4,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 5,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          },
          {
            'day': 6,
            'isActive': false,
            'start': '00:00',
            'end': '00:00',
          }
        ];
  }

  static Map<String, dynamic> modelToJson(TransportAdvertModel model) {
    return {
      'title': model.title,
      'description': model.description,
      'dialCode': model.dialCode,
      'phone': model.phone,
      'address': model.address,
      'geoPoint': model.geoPoint,
      'date': model.foundedDate,
      'pricePerKm': model.pricePerKm,
      'isActive': model.isActive,
      'isIntercity': model.isIntercity,
      'hasCage': model.hasCage,
      'hasCollar': model.hasCollar,
      'canCatch': model.canCatch,
      'shifts': model.shifts,
      // 'images': model.images,
    };
  }

  TransportAdvertModel.empty() {
    id = '';
    title = '';
    description = '';
    dialCode = '';
    phone = '';
    address = '';
    geoPoint = const GeoPoint(0, 0);
    foundedDate = Timestamp.now();
    pricePerKm = 0;
    isActive = true;
    isIntercity = false;
    hasCage = false;
    hasCollar = false;
    canCatch = false;
    images = [];
    shifts = [
      {
        'day': 0,
        'isActive': false,
        'start': '00:00',
        'end': '00:00',
      },
      {
        'day': 1,
        'isActive': false,
        'start': '00:00',
        'end': '00:00',
      },
      {
        'day': 2,
        'isActive': false,
        'start': '00:00',
        'end': '00:00',
      },
      {
        'day': 3,
        'isActive': false,
        'start': '00:00',
        'end': '00:00',
      },
      {
        'day': 4,
        'isActive': false,
        'start': '00:00',
        'end': '00:00',
      },
      {
        'day': 5,
        'isActive': false,
        'start': '00:00',
        'end': '00:00',
      },
      {
        'day': 6,
        'isActive': false,
        'start': '00:00',
        'end': '00:00',
      }
    ];
  }
}
