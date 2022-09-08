import 'package:mobx/mobx.dart';
part 'reservation_list_viewmodel.g.dart';

class ReservationListViewModel = ReservationListViewModelBase
    with _$ReservationListViewModel;

abstract class ReservationListViewModelBase with Store {}
