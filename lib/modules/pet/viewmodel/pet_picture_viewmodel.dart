import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/base/ui_snackbar.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/service/pet_service.dart';
part 'pet_picture_viewmodel.g.dart';

class PetPictureViewModel = PetPictureViewModelBase with _$PetPictureViewModel;

abstract class PetPictureViewModelBase with Store {
  @observable
  bool isLoading = false;
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
    isLoading = !isLoading;
    File? img0 = imageList.isNotEmpty ? imageList[0] : null;
    File? img1 = (imageList.length > 1) ? imageList[1] : null;
    await PetService.addAdverts(advert!, img0, img1)
        .then((value) => value == 'ADD' ? successfull(_) : error(_));
  }

  @action
  void error(BuildContext _) {
    isLoading = !isLoading;

    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar('Bir Hata Oluştu'));
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
