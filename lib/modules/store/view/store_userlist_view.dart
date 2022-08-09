import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/user/model/user_model.dart';
import 'package:petjoo/modules/store/model/store_advert_model.dart';
import 'package:petjoo/modules/store/viewmodel/store_userlist_viewmodel.dart';

class StoreUserListView extends StatelessWidget {
  final StoreUserListViewModel vm = StoreUserListViewModel();
  StoreUserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.getUserAdverts();
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Observer(builder: (_) {
      return Column(
        children: [
          addAdvertCard(_),
          ...vm.advertList
              .where((element) => element.userId == CurrentUser.id)
              .map((e) => advertCard(_, e))
        ],
      );
    });
  }

  Widget advertCard(BuildContext _, StoreAdvertModel model) {
    return InkWell(
      onTap: () {
        vm.openAdvert(_, model);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(model.id),
        ),
      ),
    );
  }

  Widget addAdvertCard(BuildContext _) {
    return InkWell(
      onTap: () {
        vm.newAdvert(_);
      },
      child: const Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text('Yeni İlan'),
        ),
      ),
    );
  }
}
