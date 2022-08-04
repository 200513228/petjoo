import 'package:flutter/material.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';
import 'package:petjoo/modules/home/viewmodel/home_viewmodel.dart';
import 'package:petjoo/modules/store/view/store_userlist_view.dart';
import 'package:petjoo/modules/user/model/user_model.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_user_list_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_list_view.dart';
import 'package:petjoo/presentation/chat/view/chat_list_view.dart';
import 'package:petjoo/presentation/common/extra/extra_view.dart';
import 'package:petjoo/presentation/transport_reservation/view/transport_reservation_list_view.dart';

class HomeView extends StatelessWidget {
  final Widget pageView;
  final String title;
  final HomeViewModel vm = HomeViewModel();
  HomeView({super.key, required this.pageView, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(),
      bottomNavigationBar: buildNav(context),
      floatingActionButton: buildFab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar buildAppBar(BuildContext _) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      actions: [
        IconButton(
            onPressed: () {
              vm.navigate(_, const ChatListView());
            },
            icon: const Icon(Icons.message_rounded))
      ],
    );
  }

  Widget buildBody() {
    return pageView;
  }

  Widget buildFab(BuildContext _) {
    return FloatingActionButton.extended(
      elevation: 8,
      isExtended: true,
      onPressed: () {
        vm.navigate(_, titleToWidget(title));
      },
      label: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(titleToFabTitle(title)),
      ),
    );
  }

  Widget buildNav(BuildContext _) {
    return BottomNavigationBar(
      enableFeedback: true,
      iconSize: 30,
      onTap: (value) {
        vm.navigate(_, indexToWidget(value));
      },
      items: [
        navItem(_, 'Anasayfa', Icons.home),
        navItem(_, 'Kullanıcı', Icons.person),
      ],
    );
  }

  BottomNavigationBarItem navItem(
      BuildContext context, String label, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  Widget titleToWidget(String text) {
    switch (text) {
      case 'Mağaza':
        return StoreUserListView();
      case 'Pet İlanları':
        return const AdvertUserListView();
      case 'Pet Nakil İlanları':
        return CurrentUser.hasTransport
            ? const TransportAdvertListView()
            : const TransportReservationListView();
      default:
        return const WelcomeView();
    }
  }

  Widget indexToWidget(int index) {
    switch (index) {
      case 0:
        return const WelcomeView();
      case 1:
        return const ExtraView();
      default:
        return const WelcomeView();
    }
  }

  String titleToFabTitle(String title) {
    switch (title) {
      case 'Mağaza':
        return 'İlanlarım';
      case 'Pet İlanları':
        return 'İlanlarım';
      case 'Pet Nakil İlanları':
        return CurrentUser.hasTransport ? 'İlanlarım' : 'Rezervasyonlarım';
      default:
        return '';
    }
  }
}
