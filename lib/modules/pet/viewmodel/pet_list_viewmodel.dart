import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/model/pet_filter_model.dart';
import 'package:petjoo/modules/pet/service/pet_service.dart';
import 'package:petjoo/modules/pet/view/pet_detail_view.dart';
part 'pet_list_viewmodel.g.dart';

class PetListViewModel = PetListViewModelBase with _$PetListViewModel;

abstract class PetListViewModelBase with Store {
  @observable
  List<PetAdvertModel> advertList = [];
  @observable
  List<PetAdvertModel> recoveryList = [];
  @observable
  PetFilterModel filter = PetFilterModel.filter(
    advertType: 0,
    animalGender: 0,
    animalHabit: 0,
    animalSize: 0,
    animalType: 0,
    infertility: 0,
    toiletTraining: 0,
    vaccine: 0,
  );
  @observable
  TextEditingController cont = TextEditingController();

  @action
  Future getAdverts() async {
    List<PetAdvertModel> temp = [];
    QuerySnapshot<Map<String, dynamic>> data =
        await PetService.getAdverts(isUser: false);
    for (var element in data.docs) {
      temp.add(PetAdvertModel.fromQDS(element));
    }
    temp.sort((b, a) =>
        a.date.microsecondsSinceEpoch.compareTo(b.date.microsecondsSinceEpoch));
    advertList = temp;
    recoveryList = temp;
  }

  @action
  void query(String query) {
    List<PetAdvertModel> temp = recoveryList;
    if (query == '') {
      advertList = recoveryList;
    } else {
      advertList = temp
          .where((element) =>
              ('${element.title} ${element.description} ${element.type}')
                  .contains(query))
          .toList();
    }
  }

  @action
  void resetFilter() {
    filter = PetFilterModel.filter(
      advertType: 0,
      animalGender: 0,
      animalHabit: 0,
      animalSize: 0,
      animalType: 0,
      infertility: 0,
      toiletTraining: 0,
      vaccine: 0,
    );
    advertList = recoveryList;
  }

  @action
  void setFilter(PetFilterModel model) {
    filter = model;
    List<PetAdvertModel> temp = recoveryList;
    advertList = temp
        .where((element) =>
            filter.advertType == element.type || filter.advertType == 0)
        .where((element) =>
            filter.animalGender == element.animalGender ||
            filter.animalGender == 0)
        .where((element) =>
            filter.animalHabit == element.animalHabit ||
            filter.animalHabit == 0)
        .where((element) =>
            filter.animalSize == element.animalSize || filter.animalSize == 0)
        .where((element) =>
            filter.animalType == element.animalType || filter.animalType == 0)
        .where((element) =>
            filter.infertility == element.infertility ||
            filter.infertility == 0)
        .where((element) =>
            filter.toiletTraining == element.toiletTraining ||
            filter.toiletTraining == 0)
        .where((element) =>
            filter.vaccine == element.vaccine || filter.vaccine == 0)
        .toList();
  }

  @action
  void pickAdvert(PetAdvertModel model, BuildContext _) {
    Navigator.push(_,
        MaterialPageRoute(builder: (context) => PetDetailView(model: model)));
  }
}
