import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petjoo/domain/enums/reservation/reservation_status.dart';
import 'package:petjoo/domain/repositories/transport_reservation_repository.dart';
import 'package:petjoo/infrastructure/model/transport_reservation_model.dart';

const String _reservations = "transport_reservations";

class TransportReservationRepositoryImpl extends TransportReservationRepository {
  @override
  Future<TransportReservationModelList> getReservedHours(String advertId, DateTime date) async {
    Query<Map<String, dynamic>> queryApproved = FirebaseFirestore.instance
        .collection(_reservations)
        .where('status', isEqualTo: ReservationStatus.approved.index)
        .where('advertId', isEqualTo: advertId)
        .where('date', isGreaterThanOrEqualTo: date);

    Query<Map<String, dynamic>> queryWaiting = FirebaseFirestore.instance
        .collection(_reservations)
        .where('status', isEqualTo: ReservationStatus.waiting.index)
        .where('advertId', isEqualTo: advertId)
        .where('date', isGreaterThanOrEqualTo: date);

    return await Future.wait([queryApproved.get(), queryWaiting.get()]).then((value) {
      final docs = value.fold<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([], (previousValue, element) => previousValue + element.docs);
      log(docs.map((e) => e.data()).toString());

      final lst = docs.map((e) => TransportReservationModel.fromDocument(e)).toList();
      return lst;
    }, onError: (e) {
      return <TransportReservationModel>[];
    });
  }

  @override
  Future<TransportReservationModelList> getReservations([DocumentSnapshot<Object?>? lastDocument]) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(_reservations).where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid).orderBy("date", descending: true);

    if (lastDocument != null) query = query.startAfterDocument(lastDocument);

    query = query.limit(50);
    final result = (await query.get()).docs.map((e) => TransportReservationModel.fromDocument(e)).toList();
    return result.where((x) => x.date.compareTo(DateTime.now()) == 1).toList();
  }

  @override
  Future<TransportReservationModelList> getReservationRequests([DocumentSnapshot<Object?>? lastDocument]) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(_reservations).where('advertId', isEqualTo: FirebaseAuth.instance.currentUser?.uid);
    //.where('status', isNotEqualTo: ReservationStatus.denied.index);

    if (lastDocument != null) query = query.startAfterDocument(lastDocument);

    query = query.limit(50);
    final result = (await query.get()).docs.map((e) => TransportReservationModel.fromDocument(e)).toList();
    return result.where((x) => x.date.compareTo(DateTime.now()) == 1).toList();
  }

  @override
  Future<DocumentReference<Object?>> createReservation(TransportReservationModel data) => FirebaseFirestore.instance.collection(_reservations).add(data.toJson());

  @override
  Future<void> updateReservation(TransportReservationModel data) => FirebaseFirestore.instance.collection(_reservations).doc(data.id).update(data.toJson());

  @override
  Future<void> updateReservationStatus(String reservationId, ReservationStatus status) =>
      FirebaseFirestore.instance.collection(_reservations).doc(reservationId).update({'status': status.index});

  @override
  Future<void> deleteReservation(String id) => FirebaseFirestore.instance.collection(_reservations).doc(id).delete();
}
