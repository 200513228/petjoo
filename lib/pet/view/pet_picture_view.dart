import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/pet/model/pet_advert_model.dart';
import 'package:petjoo/pet/viewmodel/pet_picture_viewmodel.dart';

class PetPictureView extends StatelessWidget {
  final PetAdvertModel model;
  final PetPictureViewModel vm = PetPictureViewModel();
  PetPictureView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setAdvert(model);
    return Scaffold(
      appBar: buildAppBar(context),
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
                ...vm.imageList.map((e) => imageTile(e)),
              ],
            );
    });
  }

  Widget imageTile(File e) {
    return badges.Badge(
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      centerTitle: true,
      title: Text('pick_photo'.tr()),
    );
  }

  Widget buildFab(BuildContext context) {
    return Observer(builder: (_) {
      return vm.isLoading
          ? Container()
          : FloatingActionButton.extended(
              onPressed: () {
                model.id != '' ? vm.updateAdvert(_) : vm.saveAdvert(context);
              },
              label: Row(
                children: [
                  const Icon(Icons.done_rounded),
                  const SizedBox(width: 10),
                  Text('complete'.tr()),
                ],
              ),
            );
    });
  }

  Widget loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Loading()],
    );
  }
}
