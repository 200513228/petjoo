import 'package:flutter/material.dart';
import 'package:petjoo/modules/current_data.dart';
import 'package:petjoo/modules/store/view/store_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: CurrentData.currentPage != 0 ? null : buildNav(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(title: const Text('PETJOO'));
  }

  Widget buildBody() {
    return StoreListView();
  }

  Widget buildNav() {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Anasayfa'),
      BottomNavigationBarItem(icon: Icon(Icons.add), label: 'asd'),
    ]);
  }
}
