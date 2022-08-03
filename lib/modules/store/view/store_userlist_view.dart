import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/viewmodel/store_userlist_viewmodel.dart';

class StoreUserListView extends StatelessWidget {
  final StoreUserListViewModel vm = StoreUserListViewModel();
  StoreUserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.getUserAdverts();
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: buildFab(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Observer(builder: (_) {
      if (vm.advertList.isEmpty) {
        return const NothingToSeeHereWidget();
      } else {
        return Column(
          children: [...vm.advertList.map((e) => advertCard(e))],
        );
      }
    });
  }

  Widget advertCard(StoreAdvertModel model) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(model.id),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('İLANLARIM'),
    );
  }

  Widget buildFab() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }
}
