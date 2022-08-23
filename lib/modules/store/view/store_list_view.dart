import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/base/string_converters.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/model/store_advert_statuses.dart';
import 'package:petjoo/modules/store/model/store_adverts_types.dart';
import 'package:petjoo/modules/store/viewmodel/store_list_viewmodel.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';

class StoreListView extends StatelessWidget {
  static final StoreListViewModel vm = StoreListViewModel();
  const StoreListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.getAdverts();
    vm.resetFilter();
    return Observer(builder: (_) {
      return Column(
        children: [
          queryText(),
          vm.advertList.isEmpty
              ? const Expanded(child: NothingToSeeHereWidget())
              : Expanded(
                  child: GridView(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: .65,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    children: [...vm.advertList.map((e) => advertTile(e, _))],
                  ),
                ),
        ],
      );
    });
  }

  Widget advertTile(StoreAdvertModel model, BuildContext _) {
    TextStyle textStyle = const TextStyle(fontSize: 13, color: Colors.white54);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff202020),
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => vm.pickAdvert(model, _),
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
                                    child: Text(
                                        storeAdvertTypes[model.type] as String,
                                        maxLines: 1)),
                                const SizedBox(width: 5),
                              ]),
                          const SizedBox(height: 5),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dateToString(model.date),
                                      maxLines: 1,
                                      style: textStyle,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Fiyat: ${model.price} ₺',
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
                                        style: textStyle,
                                      ),
                                      Text(
                                        'Durum: ${storeAdvertStatuses[model.status] as String}',
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
                                        style: textStyle,
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

  Widget queryText() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: vm.cont,
              autofocus: false,
              onChanged: (value) {
                vm.query(value);
              },
              decoration: const InputDecoration(
                  hintText: 'Ne Aramıştınız?',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
