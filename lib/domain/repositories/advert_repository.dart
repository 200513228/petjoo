import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/product/models/advert_filter_model.dart';
import '../../core/enums/report_types.dart';

abstract class AdvertRepository {
  Future<AdvertModelList> getAdverts([DocumentSnapshot? lastDocument]);

  Future<AdvertModel> getAdvert(String advertId);

  Future<AdvertModelList> searchAdvert({required AdvertFilterModel filter, DocumentSnapshot? lastDocument});

  Stream<AdvertModelList> getUserAdverts(String userId);

  Future<DocumentReference> createAdvert(AdvertModel data);

  Future<void> updateAdvert(AdvertModel data);

  Future<String> addAdvertImage(String advertId, File file);

  Future<void> deleteAdvertImage(String advertId, String url);

  Future<void> deleteAdvert(String advertId);

  Future<void> updateAdvertAsAdopted(String advertId);

  Future<void> reportAdvert(String advertId, String userId, ReportTypes type);
}
