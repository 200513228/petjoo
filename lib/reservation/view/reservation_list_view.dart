import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/reservation/view/reservation_tile_view.dart';
import 'package:petjoo/reservation/viewmodel/reservation_list_viewmodel.dart';
import 'package:petjoo/ui/nothing_to_see_here_widget.dart';

class ReservationListView extends StatelessWidget {
  final ReservationListViewModel vm = ReservationListViewModel();
  ReservationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.getReservations();
    return Observer(builder: (_) {
      return RefreshIndicator(
        onRefresh: () => vm.getReservations(),
        child: Column(
          children: [
            vm.reservationList.isEmpty
                ? const Expanded(child: NothingToSeeHereWidget())
                : Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        ...vm.reservationList
                            .map((e) => ReservationTileView(model: e))
                      ],
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
