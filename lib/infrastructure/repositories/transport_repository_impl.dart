import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petjoo/domain/entities/shift.dart';
import 'dart:io';
import 'package:petjoo/domain/repositories/transport_repository.dart';
import 'package:petjoo/infrastructure/model/shift_model.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import '../../core/enums/report_types.dart';

const String _transports = "transport_adverts";
const String _reports = "reports";

class TransportRepositoryImpl extends TransportRepository {
  @override
  Future<String> addTransportAdvertImage(String id, File file) async {
    final result = FirebaseStorage.instance.ref().child("transport_advert_images").child(id).child(DateTime.now().toString());
    await result.putFile(file);
    final url = await result.getDownloadURL();
    await FirebaseFirestore.instance.collection(_transports).doc(id).update({
      "images": FieldValue.arrayUnion([url])
    });
    return url;
  }

  @override
  Future<void> createTransportAdvert(TransportAdvertModel data) =>
      FirebaseFirestore.instance.collection(_transports).doc(FirebaseAuth.instance.currentUser!.uid).set(data.toJson());

  @override
  Future<void> deleteTransportAdvert(String id) => FirebaseFirestore.instance.collection(_transports).doc(id).delete();

  @override
  Future<void> deleteTransportAdvertImage(String id, String url) async {
    await FirebaseStorage.instance.refFromURL(url).delete();
    await FirebaseFirestore.instance.collection(_transports).doc(id).update({
      "images": FieldValue.arrayRemove([url])
    });
  }

  @override
  Future<TransportAdvertModel> getTransportAdvert(String id) async {
    final query = await FirebaseFirestore.instance.collection(_transports).doc(id).get();

    return TransportAdvertModel.fromDocument(query);
  }

  @override
  Future<TransportAdvertModelList> getTransportAdverts([DocumentSnapshot<Object?>? lastDocument]) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(_transports).where("isActive", isEqualTo: true);

    if (lastDocument != null) query = query.startAfterDocument(lastDocument);

    query = query.limit(50);
    return (await query.get()).docs.map((e) => TransportAdvertModel.fromDocument(e)).toList();
  }

  @override
  Future<void> reportTransportAdvert(String id, String userId, ReportTypes type) =>
      FirebaseFirestore.instance.collection(_transports).doc(id).collection(_reports).add({"userId": userId, "type": ReportTypes.spam.index});

  @override
  Future<void> updateTransportAdvert(TransportAdvertModel data) =>
      FirebaseFirestore.instance.collection(_transports).doc(data.id).update(data.toJson());

  @override
  Future<void> updateTransportAdvertShifts(String transportAdvertId, List<Shift> shifts) => FirebaseFirestore.instance
      .collection(_transports)
      .doc(transportAdvertId)
      .update({'shifts': shifts.map((e) => (e as ShiftModel).toJson()).toList()});
}
