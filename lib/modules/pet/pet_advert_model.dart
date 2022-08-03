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
    animalAge = data['animalAge'];
    animalGender = data['animalGender'];
    animalHabit = data['animalHabit'];
    animalSize = data['animalSize'];
    animalType = data['animalType'];
    date = data['date'];
    description = data['description'];
    dialCode = data['dialCode'];
    geoPoint = data['geoPoint'];
    images = data['images'];
    infertility = data['infertility'];
    isAdopted = data['isAdopted'];
    phone = data['phone'];
    title = data['title'];
    toiletTraining = data['toiletTraining'];
    type = data['type'];
    userId = data['userId'];
    vaccine = data['vaccine'];
  }
}
