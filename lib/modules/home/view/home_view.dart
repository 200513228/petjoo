import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';
import 'package:petjoo/modules/home/viewmodel/home_viewmodel.dart';
import 'package:petjoo/modules/settings/view/settings_view.dart';
import 'package:petjoo/modules/store/view/store_list_view.dart';
import 'package:petjoo/modules/store/view/store_userlist_view.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_list_view.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_user_list_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_list_view.dart';
import 'package:petjoo/presentation/chat/view/chat_list_view.dart';
import 'package:pandabar/pandabar.dart';
import 'package:petjoo/presentation/transport_reservation/view/transport_reservation_list_view.dart';

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
    return PandaBar(
      fabIcon: const Icon(Icons.filter_alt_rounded),
      fabColors: const [
        Color(0xff202020),
        Color(0xff423f3f),
      ],
      buttonSelectedColor: Colors.white,
      buttonColor: Colors.white,
      buttonData: [
        PandaBarButtonData(id: 'home', icon: Icons.home, title: 'Anasayfa'),
        PandaBarButtonData(
            id: 'custom1', icon: toCustom1Icon, title: toCustom1Title),
        PandaBarButtonData(
            id: 'custom2', icon: toCustom2Icon, title: toCustom2Title),
        PandaBarButtonData(
            id: 'settings', icon: Icons.settings, title: 'Ayarlar'),
      ],
      onChange: (id) {
        id == 'home' ? vm.navigate(_, WelcomeView(), false) : null;
        id == 'settings' ? vm.navigate(_, SettingsView(), true) : null;
        id == 'custom1' || id == 'custom2'
            ? vm.swithPage(pageSwitch(id))
            : null;
      },
      onFabButtonPressed: () {},
    );
  }

  Widget pageSwitch(String id) {
    switch (title) {
      case 'Pazar İlanları':
        return id == 'custom1' ? StoreListView() : StoreUserListView();
      case 'Pet İlanları':
        return id == 'custom1'
            ? const AdvertListView()
            : const AdvertUserListView();
      case 'Pet Nakil İlanları':
        return id == 'custom1'
            ? const TransportAdvertListView()
            : const TransportReservationListView();
      default:
        return Container();
    }
  }

  String get toCustom1Title {
    switch (title) {
      case 'Pazar İlanları':
        return 'Tüm İlanlar';
      case 'Pet İlanları':
        return 'Tüm İlanlar';
      case 'Pet Nakil İlanları':
        return 'Tüm İlanlar';
      default:
        return 'Tüm İlanlar';
    }
  }

  String get toCustom2Title {
    switch (title) {
      case 'Pazar İlanları':
        return 'İlanlarım';
      case 'Pet İlanları':
        return 'İlanlarım';
      case 'Pet Nakil İlanları':
        return 'Rezervasyonlarım';
      default:
        return 'İlanlarım';
    }
  }

  IconData get toCustom1Icon {
    switch (title) {
      case 'Pazar İlanları':
        return Icons.book;
      case 'Pet İlanları':
        return Icons.book;
      case 'Pet Nakil İlanları':
        return Icons.book;
      default:
        return Icons.book;
    }
  }

  IconData get toCustom2Icon {
    switch (title) {
      case 'Pazar İlanları':
        return Icons.list;
      case 'Pet İlanları':
        return Icons.list;
      default:
        return Icons.list;
    }
  }

  void titleToPage() {
    Widget page = Container();
    switch (title) {
      case 'Pazar İlanları':
        page = StoreListView();
        break;
      case 'Pet İlanları':
        page = const AdvertListView();
        break;
      case 'Pet Nakil İlanları':
        page = const TransportAdvertListView();
        break;
      default:
        page = Container();
    }
    vm.swithPage(page);
  }
}
