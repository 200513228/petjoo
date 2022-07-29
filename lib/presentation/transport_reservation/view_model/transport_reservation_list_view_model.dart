import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/domain/repositories/transport_reservation_repository.dart';
import '../../../infrastructure/model/transport_reservation_model.dart';

class TransportReservationListViewModel extends PageNotifier {
  TransportReservationListViewModel(super.context, this._repository) {
    refreshReservations();
  }
  final TransportReservationRepository _repository;

  TransportReservationModelList reservationList = [];

  late final scrollController = ScrollController()..addListener(_scrollListener);

  Future<void> refreshReservations() async {
    reservationList = await _repository.getReservations();
    notifyListeners();
  }

  Future<void> getMoreReservations() async {
    reservationList.addAll(await _repository.getReservations(reservationList.lastOrNull?.document));
    notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      getMoreReservations();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
