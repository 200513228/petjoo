import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/domain/entities/advert.dart';

import '../../domain/enums/advert/advert_type.dart';
import '../../domain/enums/advert/animal_gender.dart';
import '../../domain/enums/advert/animal_habits.dart';
import '../../domain/enums/advert/animal_size.dart';
import '../../domain/enums/advert/animals.dart';
import '../../domain/enums/advert/infertility.dart';
import '../../domain/enums/advert/toilet_training.dart';
import '../../domain/enums/advert/vaccine.dart';

typedef AdvertModelList = List<AdvertModel>;

class AdvertModel extends Advert {
  AdvertModel(
      {super.id,
      required super.userId,
      super.animalAge = '',
      super.images,
      super.title = '',
      super.description = '',
      super.dialCode = '',
      super.phone = '',
      required super.date,
      super.type = AdvertType.none,
      super.isAdopted = false,
      super.animalType = Animals.none,
      super.animalGender = AnimalGender.none,
      super.animalSize = AnimalSize.none,
      super.animalHabit = AnimalHabits.none,
      super.infertility = Infertility.none,
      super.toiletTraining = ToiletTraining.none,
      super.vaccine = Vaccine.none,
      super.geoPoint,
      super.document});

  factory AdvertModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data()!;
    return AdvertModel(
        id: snapshot.id,
        userId: json['userId'] as String? ?? json['user']['id'],
        geoPoint: json['geoPoint'] as GeoPoint?,
        images: (json['images'] as List).cast<String>(),
        title: json['title'] as String,
        description: json['description'] as String,
        animalAge: json['animalAge'] as String? ?? json['age'] as String,
        dialCode: json['dialCode'] as String,
        phone: json['phone'] as String,
        date: (json['date'] as Timestamp).toDate(),
        isAdopted: json['isAdopted'] as bool,
        animalType: Animals.values[json['animalType'] as int? ?? json['type'] as int],
        animalGender: AnimalGender.values[json['animalGender'] as int? ?? json['gender'] as int],
        animalSize: AnimalSize.values[json['animalSize'] as int? ?? json['size'] as int],
        type: AdvertType.values[json['status'] as int? ?? json['type'] as int],
        animalHabit: AnimalHabits.values[json['animalHabit'] as int? ?? 1],
        infertility: Infertility.values[json['infertility'] as int? ?? 1],
        toiletTraining: ToiletTraining.values[json['toiletTraining'] as int? ?? 1],
        vaccine: Vaccine.values[json['vaccine'] as int? ?? 1],
        document: snapshot);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'geoPoint': geoPoint,
        'images': images,
        'title': title,
        'description': description,
        'animalAge': animalAge,
        'dialCode': dialCode,
        'phone': phone,
        'date': Timestamp.fromDate(date),
        'isAdopted': isAdopted,
        'infertility': infertility.index,
        'toiletTraining': toiletTraining.index,
        'vaccine': vaccine.index,
        'type': type.index,
        'status': null,
        'animalType': animalType.index,
        'animalGender': animalGender.index,
        'animalSize': animalSize.index,
        'animalHabit': animalHabit.index
      };
}
