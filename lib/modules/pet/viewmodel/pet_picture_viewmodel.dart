import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
part 'pet_picture_viewmodel.g.dart';

class PetPictureViewModel = PetPictureViewModelBase with _$PetPictureViewModel;

abstract class PetPictureViewModelBase with Store {
  @observable
  PetAdvertModel? advert;
  @observable
  List<File> imageList = [];

  @action
  Future imagePick() async {
    List<File> tempList = imageList;
    XFile? tempImage;
    tempImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    if (tempImage != null) {
      tempList.add(File(tempImage.path));
    } else {}
    imageList = tempList;
  }

  @action
  Future setAdvert(PetAdvertModel model) async {
    advert = model;
  }

  @action
  Future saveAdvert(BuildContext _) async {
    // await StoreService.addAdverts(advert!, imageList[0], imageList[1])
    //     .then((value) => value ? successfull(_) : error(_));
  }

  @action
  void error(BuildContext _) {}

  @action
  void successfull(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView(title: 'İLANLAR')),
        (route) => false);
  }
}
