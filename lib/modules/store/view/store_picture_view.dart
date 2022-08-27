import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/viewmodel/store_picture_viewmodel.dart';

class StorePictureView extends StatelessWidget {
  final StorePictureViewModel vm = StorePictureViewModel();
  final StoreAdvertModel model;
  StorePictureView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setAdvert(model);
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildFab(context),
    );
  }

  Widget buildBody() {
    return Observer(builder: (_) {
      return vm.isLoading
          ? loading()
          : GridView(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15),
              children: [
                if (vm.imageList.length < 2) pickerButton,
                ...vm.imageList.map((e) => Image.file(e)),
              ],
            );
    });
  }

  Widget imageTile(File e) {
    return Badge(
      badgeContent: IconButton(
          onPressed: () {
            vm.imageDelete(e);
          },
          icon: const Icon(Icons.delete)),
      child: Image.file(e),
    );
  }

  Widget get pickerButton {
    return InkWell(
      onTap: () => vm.imagePick(),
      child: const Card(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.add_a_photo_rounded,
        ),
      )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Fotoğraf Seçimi'),
    );
  }

  Widget loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Loading()],
    );
  }

  Widget buildFab(BuildContext context) {
    return Observer(builder: (_) {
      return vm.isLoading
          ? Container()
          : FloatingActionButton(
              onPressed: () => vm.saveAdvert(context),
              child: const Icon(Icons.done_rounded),
            );
    });
  }
}
