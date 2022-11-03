import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/ui/please_auth.dart';
import 'package:petjoo/store/model/store_advert_deliveries.dart';
import 'package:petjoo/store/model/store_advert_model.dart';
import 'package:petjoo/store/model/store_advert_statuses.dart';
import 'package:petjoo/store/model/store_adverts_types.dart';
import 'package:petjoo/store/viewmodel/store_detail_viewmodel.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:petjoo/constants/images.dart';

class StoreDetailView extends StatelessWidget {
  final StoreDetailViewModel vm = StoreDetailViewModel();
  final StoreAdvertModel model;
  StoreDetailView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setModel(model);
    vm.userInfo(model.userId);
    return Scaffold(
      appBar: buildAppBar(context),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        title(),
                        advertInfo(context),
                      ],
                    ),
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

  Widget advertInfo(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: advertInfoCard(storeAdvertTypes[model.type] as String,
                  Icons.dataset_outlined, Colors.orangeAccent, 'category'.tr()),
            ),
            Expanded(
              child: advertInfoCard(storeAdvertStatuses[model.status] as String,
                  Icons.store_rounded, Colors.blueAccent, 'status'.tr()),
            ),
            Expanded(
              child: advertInfoCard(
                  storeAdvertDeliveries[model.delivery] as String,
                  Icons.delivery_dining_rounded,
                  Colors.greenAccent,
                  'delivery'.tr()),
            ),
          ],
        ),
        advertDesc,
        advertAdress(context),
      ],
    );
  }

  Widget advertInfoCard(String text, IconData icon, Color color, String title) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white54),
              )),
          Icon(icon, size: 35, color: color),
          Text(
            text,
            style: const TextStyle(fontSize: 13),
            maxLines: 1,
          ),
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
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'description'.tr(),
                style: const TextStyle(fontSize: 15, color: Colors.white54),
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

  Widget advertAdress(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'address'.tr(),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white54),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              model.address,
                              maxLines: 5,
                              style: const TextStyle(fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () {
                        vm.advert!.geoPoint.latitude != 0
                            ? vm.showLocation()
                            : null;
                      },
                      backgroundColor: colorPalette['primary'],
                      foregroundColor: Colors.black,
                      // color: colorPalette['primary'],
                      label: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on),
                            Text('map'.tr()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    return Observer(builder: (_) {
      return SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (vm.advert!.userId == CurrentUser.id)
                    Expanded(
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        backgroundColor: Colors.grey.shade800,
                        label: Text(
                          model.isSold ? 'isforsale'.tr() : 'isnotsale'.tr(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                        onPressed: () async {
                          if (!model.isSold) {
                            await showDialog(
                                context: _,
                                builder: (context) => AlertDialog(
                                      title: Text('sold_alert_title'.tr()),
                                      content: Text('sold_alert_content'.tr()),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('close'.tr())),
                                      ],
                                    )).then(
                                (value) => vm.changeSold(!model.isSold, _));
                          } else {
                            vm.changeSold(!model.isSold, _);
                          }
                        },
                      ),
                    ),
                  if (vm.advert!.userId != CurrentUser.id)
                    Expanded(
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        backgroundColor: Colors.black,
                        label: Row(
                          children: [
                            image(),
                            const SizedBox(width: 5),
                            Text(
                              vm.userName ?? 'user_not_found'.tr(),
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        onPressed: null,
                      ),
                    ),
                ],
              ),
            ),
            ...CurrentUser.id == model.userId
                ? [
                    const SizedBox(width: 10),
                    FloatingActionButton(
                        elevation: 0,
                        onPressed: () => vm.delete(_),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        )),
                    const SizedBox(width: 10),
                    FloatingActionButton(
                        heroTag: null,
                        onPressed: () => vm.editModel(model, _),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.orangeAccent,
                        ))
                  ]
                : [
                    const SizedBox(width: 10),
                    FloatingActionButton(
                        elevation: model.phone == '' ? 0 : null,
                        onPressed: () {
                          CurrentUser.id == ''
                              ? showDialog(
                                  context: _,
                                  builder: (context) => const PleaseAuth())
                              : model.phone == ''
                                  ? null
                                  : vm.call();
                        },
                        child: Icon(
                          Icons.call_rounded,
                          color: model.phone == ''
                              ? Colors.grey
                              : Colors.greenAccent,
                        )),
                    const SizedBox(width: 10),
                    FloatingActionButton(
                        heroTag: null,
                        onPressed: () {
                          CurrentUser.id == ''
                              ? showDialog(
                                  context: _,
                                  builder: (context) => const PleaseAuth())
                              : vm.message(_);
                        },
                        child: const Icon(
                          Icons.message_rounded,
                          color: Colors.orangeAccent,
                        ))
                  ],
          ],
        ),
      );
    });
  }

  Widget image() {
    return Container(
      width: 35,
      height: 35,
      decoration: const BoxDecoration(
          color: Colors.yellowAccent,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: vm.userImage == ''
            ? Image.asset(Images.noImage)
            : Image.network(
                vm.userImage,
                fit: BoxFit.cover,
              ),
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
      child: Row(
        children: [
          Expanded(
            child: Text(
              model.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
                color: colorPalette['secondary'],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Text(
              '${model.price} ₺',
              maxLines: 1,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
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
              backgroundColor: Colors.black,
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: Colors.white,
                  )),
            ),
            backgroundColor: Colors.black,
            body: PageView(
              children: [
                if (model.images.isEmpty) Image.asset(Images.noImage),
                ...model.images.map((e) => GestureDetector(
                      child: Image.network(e),
                    )),
              ],
            )));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      centerTitle: true,
      title: Text('advert_details'.tr()),
      actions: [
        PopupMenuButton(
            color: Colors.black,
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () => vm.publish(context),
                    child: Text(
                      'publish'.tr(),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () => vm.report(context),
                    child: Text(
                      'report'.tr(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ]),
      ],
    );
  }
}
