import 'package:flutter/material.dart';
import 'package:petjoo/reservation/viewmodel/reservation_list_viewmodel.dart';
import 'package:petjoo/ui/nothing_to_see_here_widget.dart';

class ReservationListView extends StatelessWidget {
  final ReservationListViewModel vm = ReservationListViewModel();
  ReservationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: NothingToSeeHereWidget(),
    );
  }
}
