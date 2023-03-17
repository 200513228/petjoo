import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/base/string_converters.dart';
import 'package:petjoo/constants/images.dart';
import 'package:petjoo/pet/model/pet_advert_animals.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/reservation/viewmodel/reservation_detail_viewmodel.dart';
import 'package:petjoo/ui/please_auth.dart';
import 'package:petjoo/user/model/current_user.dart';

class ReservationDetailView extends StatelessWidget {
  final ReservationDetailViewModel vm = ReservationDetailViewModel();
  final ReservationModel model;
  ReservationDetailView({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    vm.setModels(model);
    vm.userInfo(
        CurrentUser.id == model.advertId ? model.userId : model.advertId);
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [maps(context), ...reservationTiles(), const Divider()],
          ),
        )),
        CurrentUser.id == model.advertId ? buttons(context) : statusBar(),
        bottomContent(),
      ],
    );
  }

  List<Widget> reservationTiles() {
    double transportBegin = model.distanceA;
    double beginEnd = model.distanceB;
    TextStyle style = const TextStyle(fontSize: 16);
    TextStyle style2 = const TextStyle(fontSize: 15, color: Colors.white54);
    return [
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.black),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'date'.tr(),
                style: const TextStyle(fontSize: 15, color: Colors.white54),
              ),
            ),
            const SizedBox(height: 5),
            Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${dateToString(model.date)}  ${hourToString('${model.date.toDate().hour}:00')}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      model.isEmergancy ? 'ACİL' : '',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    )
                  ],
                )),
          ],
        ),
      ),
      Container(
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
                  'estimated_distance'.tr(),
                  style: const TextStyle(fontSize: 15, color: Colors.white54),
                ),
              ),
              const SizedBox(height: 5),
              Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${'total_distance'.tr()}:', style: style2),
                          Text('${(transportBegin + beginEnd) * 2} km',
                              style: style),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${'between_begin_end'.tr()}:', style: style2),
                          Text('$beginEnd km', style: style),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${'between_begin_company'.tr()}:',
                              style: style2),
                          Text('$transportBegin km', style: style),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.black),
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
      Row(
        children: [
          Expanded(
            child: Container(
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
                        'type'.tr(),
                        style: const TextStyle(
                            fontSize: 15, color: Colors.white54),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              petAdvertAnimals[model.animalType] as String,
                              style: const TextStyle(fontSize: 16),
                            ),
                            Icon(animalTypeToIcon(model.animalType),
                                size: 20, color: Colors.orangeAccent),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
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
                        'estimated_price'.tr(),
                        style: const TextStyle(
                            fontSize: 15, color: Colors.white54),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${((transportBegin + beginEnd) * 2 * model.resPricePerKm).toStringAsFixed(2)} ₺',
                          style: style,
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ];
  }

  Widget maps(BuildContext _) {
    return Row(
      children: [
        Expanded(child: mapTile(_, model.beginGeoPoint)),
        Expanded(child: mapTile(_, model.endGeoPoint)),
      ],
    );
  }

  Widget statusBar() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8),
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
                    'status'.tr(),
                    style: const TextStyle(fontSize: 15, color: Colors.white54),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      model.status == 0
                          ? 'waiting'.tr()
                          : model.status == 1
                              ? 'rejected'.tr()
                              : 'accepted'.tr(),
                      style: const TextStyle(fontSize: 16),
                    )),
              ],
            ),
          ),
          Icon(
              model.status == 0
                  ? Icons.hourglass_bottom
                  : model.status == 1
                      ? Icons.close
                      : Icons.done,
              color: model.status == 0
                  ? Colors.orange
                  : model.status == 1
                      ? Colors.red
                      : Colors.green)
        ],
      ),
    );
  }

  Widget buttons(BuildContext _) {
    return model.status != 0
        ? Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(8),
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
                          'status'.tr(),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white54),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            model.status == 1
                                ? 'rejected'.tr()
                                : 'accepted'.tr(),
                            style: const TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
                Icon(model.status == 1 ? Icons.close : Icons.done,
                    color: model.status == 1 ? Colors.red : Colors.green)
              ],
            ),
          )
        : Row(
            children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                          onPressed: () => vm.updateRes(_, 1),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              Expanded(
                                  child: Text('reject'.tr(),
                                      textAlign: TextAlign.center)),
                            ],
                          )))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                          onPressed: () => vm.updateRes(_, 2),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                              Expanded(
                                  child: Text('accept'.tr(),
                                      textAlign: TextAlign.center)),
                            ],
                          )))),
            ],
          );
  }

  Widget mapTile(BuildContext _, GeoPoint geo) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 200,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: GoogleMap(
              onTap: (argument) => vm.showLocation(_, geo),
              initialCameraPosition: CameraPosition(
                  target: LatLng(geo.latitude, geo.longitude), zoom: 16),
              myLocationButtonEnabled: false,
              markers: {
                Marker(
                    markerId: MarkerId(geo.toString()),
                    position: LatLng(geo.latitude, geo.longitude))
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomContent() {
    return Observer(builder: (_) {
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xff202020),
          border: Border(
            top: BorderSide(width: .5, color: Colors.white),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SafeArea(
          child: Row(
            children: [
              model.advertId == CurrentUser.id
                  ? Expanded(
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        backgroundColor: Colors.black,
                        label: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            image(),
                            const SizedBox(width: 5),
                            Text(
                              model.fullName,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        onPressed: null,
                      ),
                    )
                  : Expanded(
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        backgroundColor: Colors.black,
                        label: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            image(),
                            const SizedBox(width: 5),
                            Text(
                              vm.userName ?? 'user_not_found'.tr(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        onPressed: null,
                      ),
                    ),
              const SizedBox(width: 10),
              ...[
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
                      color:
                          model.phone == '' ? Colors.grey : Colors.greenAccent,
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
              ]
            ],
          ),
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      centerTitle: true,
      title: Text('reservation_details'.tr()),
      actions: [
        PopupMenuButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            color: Colors.black,
            itemBuilder: (context) => [
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

  IconData animalTypeToIcon(int status) {
    switch (status) {
      case 0:
        return Icons.more_horiz_rounded;
      case 1:
        return Icons.more_horiz_rounded;
      case 2:
        return FontAwesomeIcons.dog;
      case 3:
        return FontAwesomeIcons.cat;
      case 4:
        return FontAwesomeIcons.kiwiBird;
      case 5:
        return FontAwesomeIcons.fish;
      case 6:
        return FontAwesomeIcons.bug;
      default:
        return Icons.more_horiz_rounded;
    }
  }
}
