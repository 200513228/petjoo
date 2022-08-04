import 'package:flutter/material.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/viewmodel/store_detail_viewmodel.dart';
import 'package:petjoo/modules/user/model/user_model.dart';

class StoreDetailView extends StatelessWidget {
  final StoreDetailViewModel vm = StoreDetailViewModel();
  final StoreAdvertModel model;
  StoreDetailView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: buildFab(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        dataCard(model.id),
        dataCard(model.userId),
        dataCard(model.title),
        dataCard(model.date.toString()),
      ],
    );
  }

  Widget dataCard(String data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(data),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('İlan Detayları'),
    );
  }

  Widget buildFab() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(model.userId == CurrentUser.id ? Icons.edit : Icons.call),
    );
  }
}
