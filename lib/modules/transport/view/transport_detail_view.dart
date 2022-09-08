import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/modules/base/color_palette.dart';
import 'package:petjoo/modules/base/please_auth.dart';
import 'package:petjoo/modules/base/string_converters.dart';
import 'package:petjoo/modules/transport/model/transport_advert_model.dart';
import 'package:petjoo/modules/transport/viewmodel/transport_detail_viewmodel.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/ui/themes/classic_theme.dart';

class TransportDetailView extends StatelessWidget {
  final TransportAdvertModel model;
  final TransportDetailViewModel vm = TransportDetailViewModel();
  TransportDetailView({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    vm.setModel(model);
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
                        title,
                        advertInfo,
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

  Widget get advertInfo {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: advertInfoCard('Şehirlerarası',
                  FontAwesomeIcons.earthAmericas, model.isIntercity),
            ),
            Expanded(
              child: advertInfoCard(
                  'Kafes', FontAwesomeIcons.shieldDog, model.hasCage),
            ),
            Expanded(
              child: advertInfoCard(
                  'Tasma', Icons.circle_outlined, model.hasCollar),
            ),
            Expanded(
              child: advertInfoCard(
                  'Yakalama', FontAwesomeIcons.personRunning, model.canCatch),
            ),
          ],
        ),
        advertDesc,
        advertLocation,
        for (int i = 0; i < 7; i++) workHours(model.shifts[i])
      ],
    );
  }

  Widget workHours(Map map) {
    bool isActive = map['isActive'];
    String start = map['start'];
    String end = map['end'];
    int i = map['day'];
    String day = 'Pazartesi';
    switch (i) {
      case 0:
        day = 'Pazartesi';
        break;
      case 1:
        day = 'Salı';
        break;
      case 2:
        day = 'Çarşamba';
        break;
      case 3:
        day = 'Perşembe';
        break;
      case 4:
        day = 'Cuma';
        break;
      case 5:
        day = 'Cumartesi';
        break;
      case 6:
        day = 'Pazar';
        break;
      default:
    }
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.black),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(day)),
                Text(
                    isActive
                        ? '${hourToString(start)}-${hourToString(end)}'
                        : 'KAPALI',
                    style: TextStyle(
                        color: isActive ? Colors.greenAccent : Colors.red)),
              ],
            ),
          ],
        ),
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

  Widget get advertLocation {
    return InkWell(
      onTap: () {
        log('message');
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.black),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'address'.tr(),
                      style:
                          const TextStyle(fontSize: 15, color: Colors.white54),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      model.address,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.location_on),
                    Text('Harita'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget advertInfoCard(String title, IconData icon, bool isTrue) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 7.5),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        children: [
          Text(title,
              maxLines: 1,
              style: const TextStyle(fontSize: 10, color: Colors.white54)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              icon,
              size: 20,
              color: isTrue
                  ? Colors.white.withOpacity(.9)
                  : ClassicTheme.myTheme()
                      .colorScheme
                      .onSurface
                      .withOpacity(.2),
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
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () => vm.makeReservation(_),
              label: const Text('Rezervasyon Yap'),
            ),
          ),
          ...CurrentUser.id == model.id
              ? [
                  const SizedBox(width: 10),
                  FloatingActionButton(
                      elevation: 0,
                      onPressed: () => vm.changeActive(_),
                      child: Icon(
                        !model.isActive
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: Colors.redAccent,
                      )),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                      heroTag: null,
                      onPressed: () => vm.edit(_),
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
  }

  Widget get title {
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
              '${model.pricePerKm}₺/km',
              maxLines: 1,
              style: const TextStyle(fontSize: 13, color: Colors.white),
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
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            color: Colors.black,
            itemBuilder: (context) => [
                  PopupMenuItem(
                    // onTap: () => vm.publish(context),
                    child: Text(
                      'publish'.tr(),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: null,
                    child: Text(
                      'report'.tr(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ])
      ],
    );
  }
}
