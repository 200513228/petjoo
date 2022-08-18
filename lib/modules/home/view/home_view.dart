import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';
import 'package:petjoo/modules/home/viewmodel/home_viewmodel.dart';
import 'package:petjoo/modules/pet/view/pet_list_view.dart';
import 'package:petjoo/modules/pet/view/pet_userlist_view.dart';
import 'package:petjoo/modules/settings/view/settings_view.dart';
import 'package:petjoo/modules/store/view/store_list_view.dart';
import 'package:petjoo/modules/store/view/store_userlist_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_list_view.dart';
import 'package:petjoo/presentation/chat/view/chat_list_view.dart';
import 'package:petjoo/presentation/transport_reservation/view/transport_reservation_list_view.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class HomeView extends StatelessWidget {
  final String title;
  final HomeViewModel vm = HomeViewModel();
  HomeView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    titleToPage();
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(),
        bottomNavigationBar: buildBottomBar(context),
        floatingActionButton: buildFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  AppBar buildAppBar(BuildContext _) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      actions: [
        IconButton(
            onPressed: () {
              vm.navigate(_, const ChatListView(), true);
            },
            icon: const Icon(Icons.message_rounded))
      ],
    );
  }

  Widget buildBody() {
    return Observer(builder: (_) {
      return vm.currentPage;
    });
  }

  Widget buildBottomBar(BuildContext _) {
    return Observer(builder: (_) {
      return StylishBottomBar(
        currentIndex: vm.currentIndex,
        backgroundColor: const Color(0xff202020),
        items: [
          AnimatedBarItems(
            icon: const Icon(Icons.home),
            title: const Text('Anasayfa'),
            unSelectedColor: Colors.white,
            selectedColor: Colors.white,
          ),
          AnimatedBarItems(
            icon: Icon(toCustom1Icon),
            title: Text(toCustom1Title),
            unSelectedColor: Colors.white,
            selectedColor: Colors.white54,
          ),
          AnimatedBarItems(
            icon: Icon(toCustom2Icon),
            title: Text(toCustom2Title),
            unSelectedColor: Colors.white,
            selectedColor: Colors.white54,
          ),
          AnimatedBarItems(
            icon: const Icon(Icons.settings),
            title: const Text('Ayarlar'),
            unSelectedColor: Colors.white,
            selectedColor: Colors.white,
          )
        ],
        fabLocation: StylishBarFabLocation.center,
        onTap: (id) {
          id == 0 ? vm.navigate(_, WelcomeView(), false) : null;
          id == 3 ? vm.navigate(_, SettingsView(), true) : null;
          id == 1 || id == 2 ? vm.swithPage(pageSwitch(id!), id) : null;
        },
      );
    });
  }

  Widget buildFab() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.filter_alt_rounded),
    );
  }

  Widget pageSwitch(int id) {
    switch (title) {
      case 'PAZAR':
        return id == 1 ? StoreListView() : StoreUserListView();
      case 'PET':
        return id == 1 ? PetListView() : PetUserList();
      case 'PET NAKİL':
        return id == 1
            ? const TransportAdvertListView()
            : const TransportReservationListView();
      default:
        return Container();
    }
  }

  String get toCustom1Title {
    switch (title) {
      case 'PAZAR':
        return 'Tüm İlanlar';
      case 'PET':
        return 'Tüm İlanlar';
      case 'PET NAKİL':
        return 'Tüm İlanlar';
      default:
        return 'Tüm İlanlar';
    }
  }

  String get toCustom2Title {
    switch (title) {
      case 'PAZAR':
        return 'İlanlarım';
      case 'PET':
        return 'İlanlarım';
      case 'PET NAKİL':
        return 'Rezervasyonlar';
      default:
        return 'İlanlarım';
    }
  }

  IconData get toCustom1Icon {
    switch (title) {
      case 'PAZAR':
        return Icons.book;
      case 'PET':
        return Icons.book;
      case 'PET NAKİL':
        return Icons.book;
      default:
        return Icons.book;
    }
  }

  IconData get toCustom2Icon {
    switch (title) {
      case 'PAZAR':
        return Icons.list;
      case 'PET':
        return Icons.list;
      case 'PET NAKİL':
        return Icons.list;
      default:
        return Icons.list;
    }
  }

  void titleToPage() {
    Widget page = Container();
    switch (title) {
      case 'PAZAR':
        page = StoreListView();
        break;
      case 'PET':
        page = PetListView();
        break;
      case 'PET NAKİL':
        page = const TransportAdvertListView();
        break;
      default:
        page = Container();
    }
    vm.swithPage(page, 1);
  }
}
