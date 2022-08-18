import 'package:mobx/mobx.dart';
part 'pet_picture_viewmodel.g.dart';

class PetPictureViewModel = PetPictureViewModelBase with _$PetPictureViewModel;

abstract class PetPictureViewModelBase with Store {}
