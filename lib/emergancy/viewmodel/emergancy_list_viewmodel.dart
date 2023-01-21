import 'package:mobx/mobx.dart';
part 'emergancy_list_viewmodel.g.dart';

class EmergancyListViewModel = EmergancyListViewModelBase
    with _$EmergancyListViewModel;

abstract class EmergancyListViewModelBase with Store {}
