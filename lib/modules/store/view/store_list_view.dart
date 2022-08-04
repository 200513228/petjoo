import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/view/store_detail_view.dart';
import 'package:petjoo/modules/store/viewmodel/store_list_viewmodel.dart';

class StoreListView extends StatelessWidget {
  final StoreListViewModel vm = StoreListViewModel();
  StoreListView({super.key});

  @override
  Widget build(BuildContext context) {
    vm.getAdverts();
    return Observer(builder: (_) {
      return Column(
        children: [
          ...vm.advertList.map((e) => advertTile(e, _)),
        ],
      );
    });
  }

  Widget advertTile(StoreAdvertModel model, BuildContext _) {
    return InkWell(
      onTap: () => Navigator.push(
          _, MaterialPageRoute(builder: (_) => StoreDetailView(model: model))),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          model.id,
        ),
      )),
    );
  }
}
