import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/viewmodel/pet_picture_viewmodel.dart';

class PetPictureView extends StatelessWidget {
  final PetAdvertModel model;
  final PetPictureViewModel vm = PetPictureViewModel();
  PetPictureView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              children: images,
            );
    });
  }

  List<Widget> get images {
    return [
      if (vm.imageList.length < 2) pickerButton,
      ...vm.imageList.map((e) => Image.file(e!)),
    ];
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

  Widget buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async => await vm.saveAdvert(context),
      child: const Icon(Icons.done_rounded),
    );
  }

  Widget loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Loading()],
    );
  }
}
