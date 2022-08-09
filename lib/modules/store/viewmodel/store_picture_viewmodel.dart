import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/service/store_service.dart';
part 'store_picture_viewmodel.g.dart';

class StorePictureViewModel = StorePictureViewModelBase
    with _$StorePictureViewModel;

abstract class StorePictureViewModelBase with Store {
  @observable
  StoreAdvertModel? advert;

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
  void setAdvert(StoreAdvertModel model) {
    advert = model;
  }

  @action
  Future saveAdvert(BuildContext _) async {
    await StoreService.addAdverts(advert!, imageList[0], imageList[1])
        .then((value) => value ? successfull(_) : error(_));
  }

  @action
  void error(BuildContext _) {}

  @action
  void successfull(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomeView(title: 'Pazar İlanları')),
        (route) => false);
  }
}
