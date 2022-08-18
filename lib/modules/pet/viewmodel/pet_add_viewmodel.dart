import 'package:mobx/mobx.dart';
part 'pet_add_viewmodel.g.dart';

class PetAddViewModel = PetAddViewModelBase with _$PetAddViewModel;

abstract class PetAddViewModelBase with Store {}
