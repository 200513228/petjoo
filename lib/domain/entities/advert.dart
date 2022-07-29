import 'package:cloud_firestore/cloud_firestore.dart';
import '../enums/advert/advert_type.dart';
import '../enums/advert/animal_gender.dart';
import '../enums/advert/animal_habits.dart';
import '../enums/advert/animal_size.dart';
import '../enums/advert/animals.dart';
import '../enums/advert/infertility.dart';
import '../enums/advert/toilet_training.dart';
import '../enums/advert/vaccine.dart';

typedef AdvertList = List<Advert>;

abstract class Advert {
  String? id;
  String userId;
  List<String> images;
  String title;
  String description;
  String dialCode;
  String phone;
  DateTime date;
  AdvertType type;
  bool isAdopted;
  String animalAge;
  Animals animalType;
  AnimalGender animalGender;
  AnimalSize animalSize;
  AnimalHabits animalHabit;
  Infertility infertility;
  ToiletTraining toiletTraining;
  Vaccine vaccine;
  GeoPoint? geoPoint;

  final DocumentSnapshot<Map<String, dynamic>>? document;

  Advert(
      {this.id,
      required this.animalAge,
      required List<String>? images,
      required this.userId,
      required this.title,
      required this.description,
      required this.dialCode,
      required this.phone,
      required this.date,
      required this.type,
      required this.isAdopted,
      required this.animalType,
      required this.animalGender,
      required this.animalSize,
      required this.animalHabit,
      required this.infertility,
      required this.toiletTraining,
      required this.vaccine,
      required this.geoPoint,
      required this.document})
      : images = images ?? [];
}
