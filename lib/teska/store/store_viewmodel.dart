import 'package:mobx/mobx.dart';
part 'store_viewmodel.g.dart';

class StoreViewModel = StoreViewModelBase with _$StoreViewModel;

abstract class StoreViewModelBase with Store {}
