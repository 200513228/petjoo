import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/pet/model/pet_advert_model.dart';
import 'package:petjoo/modules/pet/viewmodel/pet_userlist_viewmodel.dart';
import 'package:petjoo/product/constants/images.dart';

class PetUserList extends StatelessWidget {
  final PetUserListViewModel vm = PetUserListViewModel();
  PetUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.getAdverts();
    return Observer(builder: (_) {
      return GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: .65,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        children: [
          newAdvertTile(_),
          ...vm.advertList.map((e) => advertTile(e, _))
        ],
      );
    });
  }

  Widget newAdvertTile(BuildContext _) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff202020),
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => vm.newAdvert(_),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 1,
                child: Builder(builder: (context) {
                  return Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: const Icon(Icons.add));
                })),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Text('YENİ İLAN VER',
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              softWrap: false,
                              style: TextStyle(fontSize: 17)),
                          SizedBox(height: 5),
                        ])))
          ],
        ),
      ),
    );
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
                              style: const TextStyle(fontSize: 17)),
                          const SizedBox(height: 5),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: Text(typeToString(model.type),
                                        maxLines: 1)),
                                const SizedBox(width: 5),
                              ]),
                          const SizedBox(height: 5),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  dateToString(model.date),
                                  maxLines: 1,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Teslimat: ${deliveryToString(model.infertility)}',
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
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

  String dateToString(Timestamp date) {
    var d = date.toDate();

    return '${d.day}.${d.month}.${d.year}';
  }

  String typeToString(int type) {
    switch (type) {
      case 0:
        return 'Diğer';
      case 1:
        return 'Kermes';
      case 2:
        return 'Pet Gıda';
      case 3:
        return 'Pet Aksesuar';
      case 4:
        return 'Kişisel';
      default:
        return 'Hepsi';
    }
  }

  String deliveryToString(int delivery) {
    switch (delivery) {
      case 0:
        return 'Diğer';
      case 1:
        return 'Gel Al';
      case 2:
        return 'Şehir İçi';
      case 3:
        return 'Kargo';
      default:
        return 'Hepsi';
    }
  }

  String statusToString(int status) {
    switch (status) {
      case 0:
        return 'Diğer';
      case 1:
        return 'Sıfır';
      case 2:
        return 'İkinci El';
      case 3:
        return 'El Yapımı';
      default:
        return 'Hepsi';
    }
  }
}
