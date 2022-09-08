import 'dart:io';

import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/transport/model/transport_advert_model.dart';
import 'package:petjoo/transport/viewmodel/transport_picture_viewmodel.dart';

class TransportPictureView extends StatelessWidget {
  final TransportPictureViewModel vm = TransportPictureViewModel();
  final TransportAdvertModel model;
  TransportPictureView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setAdvert(model);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        centerTitle: true,
        title: Text('pick_photo'.tr()),
      ),
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

  Widget buildFab(BuildContext context) {
    return Observer(builder: (_) {
      return vm.isLoading
          ? Container()
          : FloatingActionButton.extended(
              onPressed: () => vm.updateAdvert(_),
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
