import 'package:flutter/material.dart';
import 'package:petjoo/teska/store/model/store_advert_model.dart';
import 'package:petjoo/teska/store/viewmodel/store_detail_viewmodel.dart';

class StoreDetailView extends StatelessWidget {
  final StoreDetailViewModel vm = StoreDetailViewModel();
  final StoreAdvertModel model;
  StoreDetailView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
