import 'package:flutter/material.dart';
import 'package:petjoo/teska/store/model/store_advert_model.dart';
import 'package:petjoo/teska/store/viewmodel/store_picture_viewmodel.dart';

class StorePictureView extends StatelessWidget {
  final StorePictureViewModel vm = StorePictureViewModel();
  final StoreAdvertModel model;
  StorePictureView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
