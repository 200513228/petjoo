import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/base/ui_snackbar.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/service/store_service.dart';
import 'package:path_provider/path_provider.dart' as path;
part 'store_picture_viewmodel.g.dart';

class StorePictureViewModel = StorePictureViewModelBase
    with _$StorePictureViewModel;

abstract class StorePictureViewModelBase with Store {
  @observable
  StoreAdvertModel? advert;
  @observable
  List<File> imageList = [];
  @observable
  bool isLoading = false;

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
  void imageDelete(File e) {
    List<File> tempList = imageList;
    tempList.remove(e);
    imageList = tempList;
  }

  @action
  Future setAdvert(StoreAdvertModel model) async {
    isLoading = !isLoading;
    advert = model;
    List<File> tempList = imageList;
    for (var element in model.images) {
      var file = await downloadFile(element.toString());
      file != null ? tempList.add(file) : null;
    }
    imageList = tempList;
    isLoading = !isLoading;
  }

  @action
  Future<File?> downloadFile(String url) async {
    final Reference ref = FirebaseStorage.instance.refFromURL(url);
    final dir = await path.getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');
    await ref.writeToFile(file);
    return file;
  }

  @action
  Future saveAdvert(BuildContext _) async {
    isLoading = !isLoading;
    File? img0 = imageList.isNotEmpty ? imageList[0] : null;
    File? img1 = (imageList.length > 1) ? imageList[1] : null;
    await StoreService.addAdverts(advert!, img0, img1)
        .then((value) => value == 'ADD' ? successfull(_) : error(_, value));
  }

  @action
  Future updateAdvert(BuildContext _) async {
    isLoading = !isLoading;
    File? img0 = imageList.isNotEmpty ? imageList[0] : null;
    File? img1 = (imageList.length > 1) ? imageList[1] : null;
    await StoreService.updateAdvert(advert!, img0, img1)
        .then((value) => value == 'UPDATE' ? successfull(_) : error(_, value));
  }

  @action
  void error(BuildContext _, String data) {
    isLoading = !isLoading;
    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar('Bir Hata Oluştu'));
  }

  @action
  void successfull(BuildContext context) {
    isLoading = !isLoading;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView(title: 'PAZAR')),
        (route) => false);
  }
}
