import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:petjoo/domain/repositories/advert_repository.dart';
import 'package:petjoo/product/models/advert_filter_model.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';

import '../../core/enums/report_types.dart';
import '../../domain/enums/advert/advert_type.dart';
import '../../domain/enums/advert/animal_gender.dart';
import '../../domain/enums/advert/animal_habits.dart';
import '../../domain/enums/advert/animal_size.dart';
import '../../domain/enums/advert/animals.dart';
import '../../domain/enums/advert/infertility.dart';
import '../../domain/enums/advert/toilet_training.dart';
import '../../domain/enums/advert/vaccine.dart';

const String _adverts = "adverts";
const String _reports = "reports";

class AdvertRepositoryImpl extends AdvertRepository {
  @override
  Future<String> addAdvertImage(String advertId, File file) async {
    final result = FirebaseStorage.instance.ref().child("advert_images").child(advertId).child(DateTime.now().toString());
    await result.putFile(file);
    final url = await result.getDownloadURL();
    await FirebaseFirestore.instance.collection(_adverts).doc(advertId).update({
      "images": FieldValue.arrayUnion([url])
    });
    return url;
  }

  @override
  Future<DocumentReference<Object?>> createAdvert(AdvertModel data) => FirebaseFirestore.instance.collection(_adverts).add(data.toJson());

  @override
  Future<void> deleteAdvert(String advertId) => FirebaseFirestore.instance.collection(_adverts).doc(advertId).delete();

  @override
  Future<void> deleteAdvertImage(String advertId, String url) async {
    await FirebaseStorage.instance.refFromURL(url).delete();
    await FirebaseFirestore.instance.collection(_adverts).doc(advertId).update({
      "images": FieldValue.arrayRemove([url])
    });
  }

  @override
  Future<AdvertModel> getAdvert(String advertId) async {
    final query = await FirebaseFirestore.instance.collection(_adverts).doc(advertId).get();

    return AdvertModel.fromDocument(query);
  }

  @override
  Future<AdvertModelList> getAdverts([DocumentSnapshot<Object?>? lastDocument]) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(_adverts).orderBy("date", descending: true).where("isAdopted", isEqualTo: false);

    if (lastDocument != null) query = query.startAfterDocument(lastDocument);

    query = query.limit(50);
    return (await query.get()).docs.map((e) => AdvertModel.fromDocument(e)).toList();
  }

  @override
  Stream<AdvertModelList> getUserAdverts(String userId) => FirebaseFirestore.instance
      .collection(_adverts)
      .where('user.id', isEqualTo: userId)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => AdvertModel.fromDocument(e)).toList());

  @override
  Future<void> reportAdvert(String advertId, String userId, ReportTypes type) =>
      FirebaseFirestore.instance.collection(_adverts).doc(advertId).collection(_reports).add({"userId": userId, "type": ReportTypes.spam.index});

  @override
  Future<AdvertModelList> searchAdvert({required AdvertFilterModel filter, DocumentSnapshot<Object?>? lastDocument}) async {
    var ref = FirebaseFirestore.instance.collection(_adverts).where("isAdopted", isEqualTo: false).orderBy("date", descending: true);
    if (filter.advertType != AdvertType.none) ref = ref.where('type', isEqualTo: filter.advertType.index);
    if (filter.animalType != Animals.none) ref = ref.where('animalType', isEqualTo: filter.animalType.index);
    if (filter.animalGender != AnimalGender.none) ref = ref.where('animalGender', isEqualTo: filter.animalGender.index);
    if (filter.animalSize != AnimalSize.none) ref = ref.where('animalSize', isEqualTo: filter.animalSize.index);
    if (filter.animalHabit != AnimalHabits.none) ref = ref.where('animalHabit', isEqualTo: filter.animalHabit.index);
    if (filter.infertility != Infertility.none) ref = ref.where('infertility', isEqualTo: filter.infertility.index);
    if (filter.toiletTraining != ToiletTraining.none) ref = ref.where('toiletTraining', isEqualTo: filter.toiletTraining.index);
    if (filter.vaccine != Vaccine.none) ref = ref.where('vaccine', isEqualTo: filter.vaccine.index);
    if (lastDocument != null) ref = ref.startAfterDocument(lastDocument);

    ref = ref.limit(50);

    final query = await ref.get();

    return query.docs.map((e) => AdvertModel.fromDocument(e)).toList();
  }

  @override
  Future<void> updateAdvert(AdvertModel data) => FirebaseFirestore.instance.collection(_adverts).doc(data.id).update(data.toJson());

  @override
  Future<void> updateAdvertAsAdopted(String advertId) => FirebaseFirestore.instance.collection(_adverts).doc(advertId).update({'isAdopted': true});
}
