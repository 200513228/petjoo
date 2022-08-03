import 'package:mobx/mobx.dart';
part 'store_detail_viewmodel.g.dart';

class StoreDetailViewModel = StoreDetailViewModelBase
    with _$StoreDetailViewModel;

abstract class StoreDetailViewModelBase with Store {}
