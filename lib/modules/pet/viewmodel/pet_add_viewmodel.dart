import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
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
  String? dialCode = CurrentUser.dialCode != '' ? CurrentUser.dialCode : null;
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

  @action
  void setAdvert(PetAdvertModel model) {
    advert = model;
  }

  @action
  update(BuildContext _) {}

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
}
