import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petjoo/teska/store/model/store_advert_model.dart';
import 'package:petjoo/teska/store/view/store_picture_view.dart';
part 'store_add_viewmodel.g.dart';

class StoreAddViewModel = StoreAddViewModelBase with _$StoreAddViewModel;

abstract class StoreAddViewModelBase with Store {
  @observable
  StoreAdvertModel? advert;

  @action
  Future nextStep(
    BuildContext context, {
    required String title,
    required String description,
    required String dialCode,
    required String phone,
    required int type,
  }) async {
    advert = StoreAdvertModel.fromManuel(
      id: 'id',
      title: title,
      description: description,
      userId: 'userId',
      dialCode: dialCode,
      phone: phone,
      images: [],
      date: Timestamp.now(),
      geoPoint: const GeoPoint(0, 0),
      type: type,
      isSold: false,
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => StorePictureView(model: advert!)));
  }
}
