import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/domain/enums/reservation/reservation_status.dart';
import '../../infrastructure/model/transport_reservation_model.dart';

abstract class TransportReservationRepository {
  Future<TransportReservationModelList> getReservedHours(String advertId, DateTime date);

  Future<TransportReservationModelList> getReservations([DocumentSnapshot? lastDocument]);

  Future<TransportReservationModelList> getReservationRequests([DocumentSnapshot? lastDocument]);

  Future<DocumentReference> createReservation(TransportReservationModel data);

  Future<void> updateReservation(TransportReservationModel data);

  Future<void> updateReservationStatus(String reservationId, ReservationStatus status);

  Future<void> deleteReservation(String id);
}
