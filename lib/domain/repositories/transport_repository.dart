import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petjoo/domain/entities/shift.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import '../../core/enums/report_types.dart';

abstract class TransportRepository {
  Future<TransportAdvertModelList> getTransportAdverts([DocumentSnapshot? lastDocument]);

  Future<TransportAdvertModel> getTransportAdvert(String id);

  // Future<TransportModelList> searchTransport({required TransportFilterModel filter, DocumentSnapshot? lastDocument});

  Future<void> createTransportAdvert(TransportAdvertModel data);

  Future<void> updateTransportAdvert(TransportAdvertModel data);

  Future<String> addTransportAdvertImage(String id, File file);

  Future<void> deleteTransportAdvertImage(String id, String url);

  Future<void> deleteTransportAdvert(String id);

  Future<void> reportTransportAdvert(String id, String userId, ReportTypes type);

  Future<void> updateTransportAdvertShifts(String transportAdvertId, List<Shift> shifts);
}
