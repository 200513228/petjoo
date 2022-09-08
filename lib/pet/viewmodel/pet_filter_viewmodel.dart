import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/pet/model/pet_filter_model.dart';
import 'package:petjoo/pet/view/pet_list_view.dart';
part 'pet_filter_viewmodel.g.dart';

class PetFilterViewModel = PetFilterViewModelBase with _$PetFilterViewModel;

abstract class PetFilterViewModelBase with Store {
  @observable
  int? advertType;
  @observable
  int? animalType;
  @observable
  int? animalGender;
  @observable
  int? animalHabit;
  @observable
  int? animalSize;
  @observable
  int? vaccine;
  @observable
  int? infertility;
  @observable
  int? toilet;

  @action
  void resetFilter(BuildContext context) {
    PetListView.vm.resetFilter();
    Navigator.pop(context);
  }

  @action
  void setFilter(BuildContext context) {
    var result = PetFilterModel.filter(
      advertType: advertType ?? 0,
      animalType: animalType ?? 0,
      animalGender: animalGender ?? 0,
      animalHabit: animalHabit ?? 0,
      animalSize: animalSize ?? 0,
      vaccine: vaccine ?? 0,
      infertility: infertility ?? 0,
      toiletTraining: toilet ?? 0,
    );
    PetListView.vm.setFilter(result);
    Navigator.pop(context);
  }

  @action
  void setCurrent() {
    advertType = PetListView.vm.filter.advertType;
    animalType = PetListView.vm.filter.animalType;
    animalGender = PetListView.vm.filter.animalGender;
    animalHabit = PetListView.vm.filter.animalHabit;
    animalSize = PetListView.vm.filter.animalSize;
    vaccine = PetListView.vm.filter.vaccine;
    infertility = PetListView.vm.filter.infertility;
    toilet = PetListView.vm.filter.toiletTraining;
  }
}
