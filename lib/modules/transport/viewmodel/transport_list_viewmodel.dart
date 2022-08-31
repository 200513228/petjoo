import 'package:mobx/mobx.dart';
part 'transport_list_viewmodel.g.dart';

class TransportListViewModel = TransportListViewModelBase
    with _$TransportListViewModel;

abstract class TransportListViewModelBase with Store {}
