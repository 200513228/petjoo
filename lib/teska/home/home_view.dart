import 'package:flutter/material.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_list_view.dart';
import 'package:petjoo/teska/current_data.dart';

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
    return AdvertListView();
  }

  Widget buildNav() {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Anasayfa'),
      BottomNavigationBarItem(icon: Icon(Icons.add), label: 'asd'),
    ]);
  }
}
