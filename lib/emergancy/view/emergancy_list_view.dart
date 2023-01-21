import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/emergancy/viewmodel/emergancy_list_viewmodel.dart';

class EmergancyListView extends StatelessWidget {
  final EmergancyListViewModel vm = EmergancyListViewModel();
  EmergancyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return const Text('acil anasayfa');
      },
    );
  }
}
