import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/constants/images.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/reservation/viewmodel/reservation_tile_viewmodel.dart';
import 'package:petjoo/ui/classic_theme.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/ui/loading.dart';

class ReservationTileView extends StatelessWidget {
  final ReservationModel model;
  final ReservationTileViewModel vm = ReservationTileViewModel();
  ReservationTileView({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    vm.setModel(model);
    vm.userInfo();
    return Observer(builder: (_) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: colorPalette['secondary']),
        height: 90,
        child: vm.isLoading
            ? const Center(child: Loading())
            : InkWell(
                onTap: () => vm.selectAdvert(model, context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      image(),
                      Expanded(child: content()),
                      actions(context),
                    ],
                  ),
                ),
              ),
      );
    });
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            model.fullName,
            style: ClassicTheme.myTheme().textTheme.bodyText1,
            maxLines: 1,
          ),
          Text(
            '${'Tahmini mesafe'.tr()} ${model.distance}',
            style: ClassicTheme.myTheme()
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.white54),
            maxLines: 1,
          ),
          Text(
            '${'Rezervasyon: '.tr()} ${vm.userName}',
            style: ClassicTheme.myTheme()
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.white54),
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget actions(BuildContext _) {
    return Row(
      children: [
        MaterialButton(
            onPressed: () => vm.call(),
            color: Colors.black,
            minWidth: 45,
            height: 45,
            elevation: 0,
            shape: const CircleBorder(),
            child: const Icon(Icons.call, color: Colors.greenAccent)),
        MaterialButton(
            onPressed: () =>
                model.advertId == model.userId ? null : vm.message(_),
            color: Colors.black,
            minWidth: 45,
            height: 45,
            elevation: 0,
            shape: const CircleBorder(),
            child: const Icon(Icons.message, color: Colors.orangeAccent)),
      ],
    );
  }

  Widget image() {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: vm.userImage == ''
            ? Image.asset(
                Images.noImage,
                fit: BoxFit.cover,
              )
            : Image.network(
                vm.userImage,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
