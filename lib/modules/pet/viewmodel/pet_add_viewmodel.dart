import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/base/ui_snackbar.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/view/pet_picture_view.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
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
  bool isLoading = false;

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
    if (formKey.currentState?.validate() ?? false) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => PetPictureView(model: advert)));
    }
  }

  @action
  void error(BuildContext _, String data) {
    isLoading = !isLoading;
    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar(data));
  }

  @action
  void successfull(BuildContext context) {
    isLoading = !isLoading;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView(title: 'İLANLAR')),
        (route) => false);
  }
}
