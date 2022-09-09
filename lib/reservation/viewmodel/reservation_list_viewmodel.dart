import 'package:mobx/mobx.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/reservation/service/reservation_service.dart';
part 'reservation_list_viewmodel.g.dart';

class ReservationListViewModel = ReservationListViewModelBase
    with _$ReservationListViewModel;

abstract class ReservationListViewModelBase with Store {
  @observable
  List<ReservationModel> reservationList = [];

  @action
  Future getReservations() async {
    List<ReservationModel> temp = [];
    var data = await ReservationService.getReservations();
    for (var element in data.docs) {
      temp.add(ReservationModel.fromQDS(element));
    }
    reservationList = temp;
  }
}
