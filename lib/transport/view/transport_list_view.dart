import 'package:badges/badges.dart' as badges;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/transport/view/transport_tile_view.dart';
import 'package:petjoo/transport/viewmodel/transport_list_viewmodel.dart';
import 'package:petjoo/ui/nothing_to_see_here_widget.dart';

class TransportListView extends StatelessWidget {
  static final TransportListViewModel vm = TransportListViewModel();
  const TransportListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.getAdverts();
    // vm.setFilter(vm.filter);
    // vm.resetFilter();
    return Observer(builder: (_) {
      return RefreshIndicator(
        color: Colors.black,
        onRefresh: () => vm.getAdverts(),
        child: Column(
          children: [
            queryText(),
            vm.advertList.isEmpty
                ? const Expanded(child: NothingToSeeHereWidget())
                : Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        ...vm.advertList.map((e) => TransportTileView(model: e))
                      ],
                    ),
                  ),
          ],
        ),
      );
    });
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
              onChanged: (value) => vm.query(value),
              decoration: InputDecoration(
                  hintText: 'home_search'.tr(),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ),
          ),
          Observer(builder: (context) {
            return badges.Badge(
              badgeContent: Icon(
                vm.sortStatus == true
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                size: 15,
                color: Colors.black,
              ),
              showBadge: vm.sortStatus != null,
              position: badges.BadgePosition.topEnd(top: -3, end: -5),
              badgeColor: Colors.transparent,
              child: IconButton(
                  onPressed: () {
                    vm.sort(vm.sortStatus == null
                        ? true
                        : (vm.sortStatus == true ? false : null));
                  },
                  icon: const Icon(
                    Icons.sort_outlined,
                    color: Colors.black,
                  )),
            );
          })
        ],
      ),
    );
  }
}
