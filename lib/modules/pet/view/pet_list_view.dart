import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/modules/base/string_converters.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/viewmodel/pet_list_viewmodel.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';

class PetListView extends StatelessWidget {
  final PetListViewModel vm = PetListViewModel();
  PetListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.getAdverts();
    return Observer(builder: (_) {
      return vm.advertList.isEmpty
          ? const NothingToSeeHereWidget()
          : GridView(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: .65,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              children: [...vm.advertList.map((e) => advertTile(e, _))],
            );
    });
  }

  Widget advertTile(PetAdvertModel model, BuildContext _) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff202020),
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        // onTap: () => vm.pickAdvert(model, _),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 1,
                child: Builder(builder: (context) {
                  return model.images.isNotEmpty
                      ? Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          child: Image.network(
                            model.images.first,
                            fit: BoxFit.fitWidth,
                          ))
                      : Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          child: Image.asset(
                            Images.noImage,
                            fit: BoxFit.cover,
                          ));
                })),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(model.title,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              softWrap: false,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: Row(
                                  children: [
                                    Text(
                                      animalTypeToString(model.animalType),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white54),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      animalTypeToIcon(model.animalType),
                                      size: 15,
                                    )
                                  ],
                                )),
                                const SizedBox(width: 5),
                              ]),
                          const SizedBox(height: 5),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(dateToString(model.date),
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white54)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        typeToString(model.type),
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: typeToColor(model.type)),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ])))
          ],
        ),
      ),
    );
  }

  String typeToString(int type) {
    switch (type) {
      case 0:
        return 'Diğer';
      case 1:
        return 'Acil';
      case 2:
        return 'Kayıp';
      case 3:
        return 'Yavru';
      case 4:
        return 'Engelsiz';
      case 5:
        return 'Geçici Yuva';
      case 6:
        return 'Kalıcı Yuva';
      case 7:
        return 'Süt Anne';
      default:
        return 'Diğer';
    }
  }

  Color typeToColor(int type) {
    switch (type) {
      case 0:
        return Colors.orangeAccent;
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.blueAccent;
      case 4:
        return Colors.greenAccent;
      case 5:
        return Colors.orangeAccent;
      case 6:
        return Colors.orangeAccent;
      case 7:
        return Colors.blueAccent;
      default:
        return Colors.orangeAccent;
    }
  }

  String animalTypeToString(int delivery) {
    switch (delivery) {
      case 0:
        return 'Diğer';
      case 1:
        return 'Diğer';
      case 2:
        return 'Köpek';
      case 3:
        return 'Kedi';
      case 4:
        return 'Kuş';
      case 5:
        return 'Akvaryum';
      case 6:
        return 'Kemirgen';
      default:
        return 'Diğer';
    }
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
