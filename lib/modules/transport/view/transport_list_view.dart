import 'package:flutter/material.dart';
import 'package:petjoo/modules/transport/viewmodel/transport_list_viewmodel.dart';

class TransportViewList extends StatelessWidget {
  final TransportListViewModel vm = TransportListViewModel();
  TransportViewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column();
  }
}
