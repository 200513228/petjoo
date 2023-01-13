import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/transport/view/transport_filter_view.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/ui/please_auth.dart';
import 'package:petjoo/chat/view/chat_list_view.dart';
import 'package:petjoo/home/view/welcome_view.dart';
import 'package:petjoo/home/viewmodel/home_viewmodel.dart';
import 'package:petjoo/pet/view/pet_filter_view.dart';
import 'package:petjoo/pet/view/pet_list_view.dart';
import 'package:petjoo/pet/view/pet_userlist_view.dart';
import 'package:petjoo/reservation/view/reservation_list_view.dart';
import 'package:petjoo/settings/view/settings_view.dart';
import 'package:petjoo/store/view/store_filter_view.dart';
import 'package:petjoo/store/view/store_list_view.dart';
import 'package:petjoo/store/view/store_userlist_view.dart';
import 'package:petjoo/transport/view/transport_list_view.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class HomeView extends StatelessWidget {
  final String title;
  final HomeViewModel vm = HomeViewModel();
  HomeView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    titleToPage();
    vm.getChatCount();
    return WillPopScope(
      onWillPop: () async {
        Navigator.canPop(context)
            ? Navigator.pop(context)
            : Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomeView()));
        return true;
      },
      child: Observer(builder: (_) {
        return Scaffold(
          appBar: buildAppBar(context),
          body: buildBody(),
          bottomNavigationBar: buildBottomBar(context),
          floatingActionButton: vm.showFab ? buildFab(context) : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      }),
    );
  }

  AppBar buildAppBar(BuildContext _) {
    return AppBar(
      centerTitle: true,
      title: Text(titleToAppBar),
      leading: IconButton(
          onPressed: () => Navigator.canPop(_)
              ? Navigator.pop(_)
              : Navigator.pushAndRemoveUntil(
                  _,
                  MaterialPageRoute(builder: (_) => WelcomeView()),
                  (route) => false),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )),
      actions: [
        IconButton(onPressed: () {
          if (CurrentUser.id == '') {
            showDialog(context: _, builder: (context) => const PleaseAuth());
          } else {
            vm.navigate(_, ChatListView(), true);
          }
        }, icon: Observer(builder: (_) {
          return Badge(
              badgeContent: Text(vm.chatCount.toString()),
              showBadge: vm.chatCount != 0,
              child: const Icon(
                Icons.message_rounded,
                color: Colors.black,
              ));
        }))
      ],
    );
  }

  Widget buildBody() {
    return Observer(builder: (_) {
      return vm.currentPage;
    });
  }

  Widget buildBottomBar(BuildContext _) {
    TextStyle style = const TextStyle(fontSize: 10);
    return Observer(builder: (_) {
      return StylishBottomBar(
        currentIndex: vm.currentIndex,
        backgroundColor: const Color(0xff202020),
        items: [
          AnimatedBarItems(
            icon: const Icon(Icons.home),
            title: Text('home_home'.tr(), style: style),
            unSelectedColor: Colors.white,
            selectedColor: Colors.white,
          ),
          AnimatedBarItems(
            icon: Icon(toCustom1Icon),
            title: Text(labelToBottom1, style: style),
            unSelectedColor: Colors.white,
            selectedColor: Colors.white54,
          ),
          AnimatedBarItems(
            icon: Icon(toCustom2Icon),
            title: Text(labelToBottom2, style: style),
            unSelectedColor: Colors.white,
            selectedColor: Colors.white54,
          ),
          AnimatedBarItems(
            icon: const Icon(Icons.settings),
            title: Text('home_settings'.tr(), style: style),
            unSelectedColor: Colors.white,
            selectedColor: Colors.white,
          )
        ],
        fabLocation: StylishBarFabLocation.center,
        onTap: (id) {
          id == 0 ? vm.navigate(_, WelcomeView(), false) : null;
          id == 3
              ? CurrentUser.id == ''
                  ? showDialog(
                      context: _, builder: (context) => const PleaseAuth())
                  : vm.navigate(_, SettingsView(), true)
              : null;
          id == 1 || id == 2 ? vm.swithPage(pageSwitch(id!), id) : null;
        },
      );
    });
  }

  String get titleToAppBar {
    switch (title) {
      case 'PAZAR':
        return 'store'.tr();
      case 'İLANLAR':
        return 'advert'.tr();
      case 'PET NAKİL':
        return 'transport'.tr();
      default:
        return ' ';
    }
  }

  String get labelToBottom1 {
    switch (title) {
      case 'PET NAKİL':
        return 'home_all_transport'.tr();
      case 'PAZAR':
        return 'home_all_products'.tr();
      default:
        return 'home_all'.tr();
    }
  }

  String get labelToBottom2 {
    switch (title) {
      case 'PET NAKİL':
        return 'home_myres'.tr();
      case 'PAZAR':
        return 'home_myproducts'.tr();
      default:
        return 'home_my'.tr();
    }
  }

  Widget buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            enableDrag: true,
            backgroundColor: colorPalette['primary'],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (context) {
              return titleToModalSheet();
            });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.filter_alt_rounded,
            size: 30,
          ),
          Text('Filtre', style: TextStyle(fontSize: 10))
        ],
      ),
    );
  }

  Widget titleToModalSheet() {
    switch (title) {
      case 'PAZAR':
        return StoreFilterView();
      case 'İLANLAR':
        return PetFilterView();
      case 'PET NAKİL':
        return TransportFilterView();
      default:
        return Column(mainAxisSize: MainAxisSize.min, children: const []);
    }
  }

  Widget pageSwitch(int id) {
    switch (title) {
      case 'PAZAR':
        return id == 1 ? const StoreListView() : StoreUserListView();
      case 'İLANLAR':
        return id == 1 ? const PetListView() : PetUserListView();
      case 'PET NAKİL':
        return id == 1 ? const TransportListView() : ReservationListView();
      default:
        return Container();
    }
  }

  IconData get toCustom1Icon {
    switch (title) {
      case 'PAZAR':
        return Icons.book;
      case 'İLANLAR':
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
      case 'İLANLAR':
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
        page = const StoreListView();
        break;
      case 'İLANLAR':
        page = const PetListView();
        break;
      case 'PET NAKİL':
        page = const TransportListView();
        break;
      default:
        page = Container();
    }
    vm.swithPage(page, 1);
  }
}
