import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/location/service/location_picker.dart';
import 'package:petjoo/pet/model/pet_advert_model.dart';
import 'package:petjoo/pet/view/pet_picture_view.dart';
import 'package:petjoo/user/model/current_user.dart';
part 'pet_add_viewmodel.g.dart';

class PetAddViewModel = PetAddViewModelBase with _$PetAddViewModel;

abstract class PetAddViewModelBase with Store {
  @observable
  PetAdvertModel advert = PetAdvertModel.empty();
  @observable
  GlobalKey<FormState> formKey = GlobalKey();
  @observable
  TextEditingController titleCont = TextEditingController();
  @observable
  TextEditingController descCont = TextEditingController();
  @observable
  TextEditingController addressCont = TextEditingController();
  @observable
  TextEditingController phoneCont =
      TextEditingController(text: CurrentUser.phone);
  @observable
  String? dialCode = CurrentUser.dialCode != '' ? CurrentUser.dialCode : '+90';
  @observable
  TextEditingController ageCont = TextEditingController();
  @observable
  int? type;
  @observable
  int? animal;
  @observable
  int? gender;
  @observable
  int? size;
  @observable
  int? habit;
  @observable
  int? infertility;
  @observable
  int? toilet;
  @observable
  int? vaccine;
  @observable
  GeoPoint? geoPoint;
  @observable
  bool isLoading = false;

  @action
  Future pickLocation(BuildContext context) async {
    geoPoint = await showLocationPicker(context);
  }

  @action
  void preEdit(PetAdvertModel model) {
    advert = model;
    titleCont.text = model.title;
    descCont.text = model.description;
    addressCont.text = model.address;
    phoneCont.text = model.phone;
    dialCode = model.dialCode;
    ageCont.text = model.animalAge;
    type = model.type;
    animal = model.animalType;
    gender = model.animalGender;
    size = model.animalSize;
    habit = model.animalHabit;
    infertility = model.infertility;
    toilet = model.toiletTraining;
    vaccine = model.vaccine;
    geoPoint = model.geoPoint;
  }

  @action
  Future nextStep(BuildContext context) async {
    advert.title = titleCont.text;
    advert.description = descCont.text;
    advert.dialCode = dialCode ?? '';
    advert.phone = phoneCont.text;
    advert.address = addressCont.text;
    advert.type = type ?? 0;
    advert.animalAge = ageCont.text;
    advert.animalType = animal ?? 0;
    advert.animalGender = gender ?? 0;
    advert.animalSize = size ?? 0;
    advert.animalHabit = habit ?? 0;
    advert.infertility = infertility ?? 0;
    advert.toiletTraining = toilet ?? 0;
    advert.vaccine = vaccine ?? 0;
    advert.geoPoint = geoPoint ?? const GeoPoint(0, 0);
    if (formKey.currentState?.validate() ?? false) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => PetPictureView(model: advert)));
    }
  }
}
