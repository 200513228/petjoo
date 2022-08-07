import 'package:flutter/material.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/viewmodel/store_detail_viewmodel.dart';
import 'package:petjoo/modules/user/model/user_model.dart';
import 'package:petjoo/product/constants/images.dart';

class StoreDetailView extends StatelessWidget {
  final StoreDetailViewModel vm = StoreDetailViewModel();
  final StoreAdvertModel model;
  StoreDetailView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setModel(model);
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: buildFab(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 3, child: gallery),
        Expanded(child: features),
      ],
    );
  }

  Widget get features {
    return Column(
      children: [
        Card(
          child: Text('Başlık ${vm.advert!.title}'),
        )
      ],
    );
  }

  Widget get gallery {
    return PageView(
      children: [
        if (vm.advert!.images.isEmpty) Image.network(Images.noImage),
        ...vm.advert!.images.map((e) => Image.network(e)),
      ],
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
      child:
          Icon(vm.advert!.userId == CurrentUser.id ? Icons.edit : Icons.call),
    );
  }
}
