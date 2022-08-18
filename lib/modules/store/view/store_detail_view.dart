import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/base/color_palette.dart';
import 'package:petjoo/modules/base/string_converters.dart';
import 'package:petjoo/modules/store/model/store_advert_deliveries.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/model/store_advert_statuses.dart';
import 'package:petjoo/modules/store/model/store_adverts_types.dart';
import 'package:petjoo/modules/store/viewmodel/store_detail_viewmodel.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
import 'package:petjoo/product/constants/images.dart';

class StoreDetailView extends StatelessWidget {
  final StoreDetailViewModel vm = StoreDetailViewModel();
  final StoreAdvertModel model;
  StoreDetailView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setModel(model);
    vm.userInfo(model.userId);
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
      backgroundColor: colorPalette['primary'],
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
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: colorPalette['secondary'],
                  child: Column(
                    children: [
                      title(),
                      // userCard(),
                      Expanded(child: advertInfo),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomBar(context)
      ],
    );
  }

  Widget get advertInfo {
    return Column(
      children: [
        userCard(),
        advertAdress,
        Row(
          children: [
            Expanded(
              child: advertInfoCard(storeAdvertTypes[model.type] as String,
                  Icons.dataset_outlined, Colors.orangeAccent, 'Kategori'),
            ),
            Expanded(
              child: advertInfoCard(storeAdvertStatuses[model.status] as String,
                  Icons.store_rounded, Colors.blueAccent, 'Durum'),
            ),
            Expanded(
              child: advertInfoCard(
                  storeAdvertDeliveries[model.delivery] as String,
                  Icons.delivery_dining_rounded,
                  Colors.greenAccent,
                  'Teslimat'),
            ),
          ],
        ),
        Expanded(child: advertDesc)
      ],
    );
  }

  Widget userCard() {
    return Observer(builder: (_) {
      return Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ListTile(
          leading: vm.userImage != null
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: CurrentUser.image != ''
                        ? Image.network(
                            CurrentUser.image,
                            fit: BoxFit.fitWidth,
                          )
                        : Image.asset(Images.noImage),
                  ))
              : CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: colorPalette['primary'],
                  )),
          trailing: Text(
            dateToString(model.date),
            style: const TextStyle(fontSize: 14),
          ),
          title: vm.userName != null
              ? Text(
                  vm.userName!,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )
              : const Text('Kullanıcı Bulunamadı',
                  style: TextStyle(color: Colors.black, fontSize: 16)),
        ),
      );
    });
  }

  Widget advertInfoCard(String text, IconData icon, Color color, String title) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Color.fromARGB(78, 235, 228, 100),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white54),
              )),
          Icon(icon, size: 35, color: color),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget get advertDesc {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.black),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Açıklama',
                style: TextStyle(fontSize: 15, color: Colors.white54),
              ),
            ),
            const SizedBox(height: 5),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  model.description,
                  style: const TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }

  Widget get advertAdress {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.black),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Adres',
              style: TextStyle(fontSize: 15, color: Colors.white54),
            ),
          ),
          const SizedBox(height: 5),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                model.address,
                style: const TextStyle(fontSize: 16),
              )),
        ],
      ),
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
        child: bottomContent(context));
  }

  Widget bottomContent(BuildContext _) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                if (model.userId == CurrentUser.id)
                  Expanded(
                    child: FloatingActionButton.extended(
                      heroTag: null,
                      backgroundColor: Colors.grey.shade800,
                      label: Text(
                        model.isSold ? 'Satılık Mı?' : 'Satıldı Mı?',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      onPressed: () {
                        vm.changeSold(!model.isSold, _);
                      },
                    ),
                  ),
                if (model.userId == CurrentUser.id) const SizedBox(width: 10),
                Expanded(
                  child: FloatingActionButton.extended(
                    heroTag: null,
                    backgroundColor: Colors.black,
                    label: Text(
                      '${model.price} ₺',
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    onPressed: null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
              elevation: model.phone == '' ? 0 : null,
              onPressed: model.phone == '' ? null : vm.call,
              child: Icon(
                Icons.call_rounded,
                color: model.phone == '' ? Colors.grey : Colors.greenAccent,
              )),
          ...CurrentUser.id == model.userId
              ? [
                  const SizedBox(width: 10),
                  FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        vm.editModel(model, _);
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.orangeAccent,
                      ))
                ]
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
  }

  Widget title() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: colorPalette['primary'],
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(15))),
      child: Text(
        model.title,
        style: const TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

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
}
