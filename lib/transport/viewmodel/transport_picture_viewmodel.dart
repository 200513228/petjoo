import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/ui/ui_snackbar.dart';
import 'package:petjoo/home/view/home_view.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/transport/service/transport_service.dart';
import 'package:path_provider/path_provider.dart' as path;
part 'transport_picture_viewmodel.g.dart';

class TransportPictureViewModel = TransportPictureViewModelBase
    with _$TransportPictureViewModel;

abstract class TransportPictureViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  TransportAdvertModel? advert;
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
  void imageDelete(File e) {
    List<File> tempList = imageList;
    tempList.remove(e);
    imageList = tempList;
  }

  @action
  Future setAdvert(TransportAdvertModel model) async {
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
  Future updateAdvert(BuildContext _) async {
    isLoading = !isLoading;
    File? img0 = imageList.isNotEmpty ? imageList[0] : null;
    File? img1 = (imageList.length > 1) ? imageList[1] : null;
    await TransportService.updateAdvert(advert!, img0, img1)
        .then((value) => value == 'UPDATE' ? successfull(_) : error(_, value));
  }

  @action
  void error(BuildContext _, String error) {
    isLoading = !isLoading;
    ScaffoldMessenger.of(_).showSnackBar(uiSnackBar('$error '));
  }

  @action
  void successfull(BuildContext context) {
    isLoading = !isLoading;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView(title: 'PET NAKİL')),
        (route) => false);
  }
}
