import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/user/model/current_user.dart';

class PetAdvertModel {
  String id = '';
  String animalAge = '0';
  int animalGender = 0;
  int animalHabit = 0;
  int animalSize = 0;
  int animalType = 0;
  Timestamp date = Timestamp.now();
  String description = '';
  String dialCode = '';
  GeoPoint geoPoint = const GeoPoint(0, 0);
  List images = [];
  int infertility = 0;
  bool isAdopted = false;
  String phone = '';
  String title = '';
  int toiletTraining = 0;
  int type = 0;
  String userId = '';
  int vaccine = 0;
  String address = '';
  String oldUserId = '';

  PetAdvertModel.fromQDS(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    animalAge = data['animalAge'] ?? '0';
    animalGender = data['animalGender'] ?? 0;
    animalHabit = data['animalHabit'] ?? 0;
    animalSize = data['animalSize'] ?? 0;
    animalType = data['animalType'] ?? 0;
    date = data['date'] ?? Timestamp.now();
    description = data['description'] ?? '';
    dialCode = data['dialCode'] ?? '';
    geoPoint = data['geoPoint'] ?? const GeoPoint(0, 0);
    images = data['images'] ?? [];
    infertility = data['infertility'] ?? 0;
    isAdopted = data['isAdopted'] ?? false;
    phone = data['phone'] ?? '';
    title = data['title'] ?? '';
    toiletTraining = data['toiletTraining'] ?? 0;
    type = data['type'] ?? 0;
    userId = data['userId'] ?? '';
    vaccine = data['vaccine'] ?? 0;
    address = data['address'] ?? '';
  }

  PetAdvertModel.fromDS(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    animalAge = data['animalAge'] ?? '0';
    animalGender = data['animalGender'] ?? 0;
    animalHabit = data['animalHabit'] ?? 0;
    animalSize = data['animalSize'] ?? 0;
    animalType = data['animalType'] ?? 0;
    date = data['date'] ?? Timestamp.now();
    description = data['description'] ?? '';
    dialCode = data['dialCode'] ?? '';
    geoPoint = data['geoPoint'] ?? const GeoPoint(0, 0);
    images = data['images'] ?? [];
    infertility = data['infertility'] ?? 0;
    isAdopted = data['isAdopted'] ?? false;
    phone = data['phone'] ?? '';
    title = data['title'] ?? '';
    toiletTraining = data['toiletTraining'] ?? 0;
    type = data['type'] ?? 0;
    userId = data['userId'] ?? '';
    vaccine = data['vaccine'] ?? 0;
    address = data['address'] ?? '';
  }

  PetAdvertModel.empty() {
    id = '';
    title = '';
    description = '';
    type = 0;
    dialCode = '';
    phone = '';
    animalAge = '0';
    animalGender = 0;
    animalHabit = 0;
    animalSize = 0;
    animalType = 0;
    toiletTraining = 0;
    vaccine = 0;
    infertility = 0;
    date = Timestamp.now();
    geoPoint = const GeoPoint(0, 0);
    images = [];
    isAdopted = false;
    userId = '';
    address = '';
  }

  static Map<String, dynamic> modelToJson(PetAdvertModel model) {
    return {
      'title': model.title,
      'description': model.description,
      'type': model.type,
      'dialCode': model.dialCode,
      'phone': model.phone,
      'animalAge': model.animalAge,
      'animalGender': model.animalGender,
      'animalHabit': model.animalHabit,
      'animalSize': model.animalSize,
      'animalType': model.animalType,
      'toiletTraining': model.toiletTraining,
      'vaccine': model.vaccine,
      'infertility': model.infertility,
      'isAdopted': false,
      'userId': CurrentUser.id,
      'address': model.address,
      'images': [],
      'date': Timestamp.now(),
      'geoPoint': model.geoPoint,
    };
  }
}
