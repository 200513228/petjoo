import 'package:cloud_firestore/cloud_firestore.dart';

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
  GeoPoint? geoPoint = const GeoPoint(0, 0);
  List images = [];
  int infertility = 0;
  bool isAdopted = false;
  String phone = '';
  String title = '';
  int toiletTraining = 0;
  int type = 0;
  String userId = '';
  int vaccine = 0;

  PetAdvertModel.fromQDS(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data() as dynamic;
    id = snapshot.id;
    animalAge = data['animalAge'] ?? '';
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
  }
}
