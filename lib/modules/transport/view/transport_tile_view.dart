import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/modules/base/color_palette.dart';
import 'package:petjoo/modules/transport/model/transport_advert_model.dart';
import 'package:petjoo/modules/transport/viewmodel/transport_tile_viewmodel.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/ui/themes/classic_theme.dart';

class TransportTileView extends StatelessWidget {
  final TransportTileViewModel vm = TransportTileViewModel();
  final TransportAdvertModel model;
  TransportTileView({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: colorPalette['secondary']),
      height: 90,
      child: InkWell(
        onTap: () => vm.selectAdvert(model, context),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              image(),
              Expanded(child: content()),
              actions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            model.title,
            style: ClassicTheme.myTheme().textTheme.bodyText1,
            maxLines: 1,
          ),
          Text(
            "₺${model.pricePerKm}/KM",
            style: ClassicTheme.myTheme()
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.white54),
            maxLines: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              featureIcon(FontAwesomeIcons.earthAmericas, model.isIntercity),
              featureIcon(FontAwesomeIcons.shieldDog, model.hasCage),
              featureIcon(Icons.circle_outlined, model.hasCollar),
              featureIcon(FontAwesomeIcons.personRunning, model.canCatch),
            ],
          )
        ],
      ),
    );
  }

  Widget actions() {
    return Row(
      children: [
        MaterialButton(
            onPressed: () {},
            color: Colors.black,
            minWidth: 45,
            height: 45,
            elevation: 0,
            shape: const CircleBorder(),
            child: const Icon(Icons.call, color: Colors.greenAccent)),
        MaterialButton(
            onPressed: () {},
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
        child: model.images.isEmpty
            ? Image.asset(
                Images.noImage,
                fit: BoxFit.cover,
              )
            : Image.network(
                model.images[0],
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget featureIcon(IconData icon, bool isActive) {
    return Icon(
      icon,
      size: 16,
      color: isActive
          ? Colors.white.withOpacity(.9)
          : ClassicTheme.myTheme().colorScheme.onSurface.withOpacity(.2),
    );
  }
}
