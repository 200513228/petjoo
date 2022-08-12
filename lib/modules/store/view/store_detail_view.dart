import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(flex: 3, child: gallery(context)),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(model.title,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            maxLines: 2),
                        dateToText(model.date),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomBar(context)
      ],
    );
  }

  Widget dateToText(Timestamp date) {
    DateTime d = date.toDate();
    return Text(
      '${d.day}.${d.month}.${d.year}',
      style: const TextStyle(color: Colors.black, fontSize: 14),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xff202020),
          border: Border(
            top: BorderSide(width: .5, color: Colors.white),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: bottomContent());
  }

  Widget bottomContent() => SafeArea(
        child: Row(
          children: [
            Expanded(
                child: FloatingActionButton.extended(
              heroTag: null,
              backgroundColor: Colors.black,
              label: Text(
                '${model.price} ₺',
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
              onPressed: null,
              // onPressed: data.geoPoint == null ? null : viewModel.getDirections,
            )),
            const SizedBox(width: 10),
            FloatingActionButton(
                heroTag: '<default FloatingActionButton tag>',
                elevation: model.phone == '' ? 0 : null,
                onPressed: model.phone == '' ? null : vm.call,
                child: Icon(
                  Icons.call_rounded,
                  color: model.phone == '' ? Colors.grey : Colors.greenAccent,
                )),
            ...CurrentUser.id == ''
                ? []
                : [
                    const SizedBox(width: 10),
                    FloatingActionButton(
                        heroTag: null,
                        onPressed: () {},
                        child: const Icon(
                          Icons.message_rounded,
                          color: Colors.orangeAccent,
                        ))
                  ],
          ],
        ),
      );

  Widget gallery(BuildContext context) {
    return Stack(
      children: [
        PageView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            if (model.images.isEmpty) Image.asset(Images.noImage),
            ...model.images.map(
              (e) => GestureDetector(
                onTap: () => fullScreen(context),
                child: Image.network(e, fit: BoxFit.fitWidth),
              ),
            ),
          ],
        ),
        // Align(alignment: Alignment.bottomCenter, child: imageCounter()),
      ],
    );
  }

  void fullScreen(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow.shade600,
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.clear_rounded)),
            ),
            backgroundColor: Colors.transparent,
            body: PageView(
              children: [
                if (model.images.isEmpty) Image.asset(Images.noImage),
                ...model.images.map((e) => GestureDetector(
                      child: Image.network(e),
                    )),
              ],
            )));
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
