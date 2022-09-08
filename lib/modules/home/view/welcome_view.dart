import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/modules/base/loading.dart';
import 'package:petjoo/modules/base/color_palette.dart';
import 'package:petjoo/modules/home/viewmodel/welcome_viewmodel.dart';
import 'package:petjoo/modules/settings/view/settings_view.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
import 'package:petjoo/modules/user/view/login_view.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomeView extends StatelessWidget {
  final WelcomeViewModel vm = WelcomeViewModel();
  WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.userLogin(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPalette['primary'],
        actions: [
          Row(
            children: [
              const Text('Language',
                  style: TextStyle(color: Colors.black, fontSize: 14)),
              appbarLocal(context),
            ],
          )
        ],
      ),
      backgroundColor: colorPalette['secondary'],
      body: Column(
        children: [
          Expanded(flex: 4, child: slider()),
          Expanded(flex: 5, child: selector(context)),
          userCard(context),
        ],
      ),
    );
  }

  Widget slider() {
    return Container(
      decoration: BoxDecoration(
        color: colorPalette['primary'],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
        child: Image.asset(Images.logo),
      ),
    );
  }

  Widget selector(BuildContext _) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Expanded(
                flex: 10,
                child: BigModule(
                  icon: Icons.pets,
                  title: 'welcome_advert'.tr(),
                  onTap: () => vm.goModule(_, 'İLANLAR'),
                ),
              ),
              Expanded(
                flex: 6,
                child: SmallModule(
                  icon: FontAwesomeIcons.compassDrafting,
                  title: 'welcome_soon'.tr(),
                  onTap: () => vm.goModule(_, 'YAKINDA'),
                ),
              ),
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Expanded(
                flex: 6,
                child: SmallModule(
                  icon: FontAwesomeIcons.truck,
                  title: 'welcome_transport'.tr(),
                  onTap: () => vm.goModule(_, 'PET NAKİL'),
                ),
              ),
              Expanded(
                flex: 10,
                child: BigModule(
                  icon: Icons.store,
                  title: 'welcome_store'.tr(),
                  onTap: () => vm.goModule(_, 'PAZAR'),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget userCard(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
        child: ListTile(
            tileColor: colorPalette['primary'],
            onTap: () {
              vm.userLog
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => SettingsView()),
                      (route) => true,
                    )
                  : Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
            },
            leading: vm.userLog
                ? Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      child: CurrentUser.image != ''
                          ? Image.network(
                              CurrentUser.image,
                              fit: BoxFit.fitWidth,
                            )
                          : Image.asset(Images.noImage),
                    ))
                : const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                    )),
            title: vm.isLoading
                ? const Loading()
                : vm.userLog
                    ? Text(
                        '${'welcome_hello'.tr()} ${CurrentUser.name}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      )
                    : Text('welcome_login_tap'.tr(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
            trailing: const Icon(
              Icons.settings,
              size: 28,
              color: Colors.black,
            )),
      );
    });
  }

  Widget appbarLocal(BuildContext context) {
    return PopupMenuButton(
        color: Colors.black,
        itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => context.setLocale(const Locale('tr')),
                child: Text('welcome_lang_tr'.tr()),
              ),
              PopupMenuItem(
                onTap: () => context.setLocale(const Locale('en')),
                child: Text('welcome_lang_en'.tr()),
              ),
              PopupMenuItem(
                onTap: () => context.setLocale(const Locale('de')),
                child: Text('welcome_lang_de'.tr()),
              ),
            ],
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.translate,
            color: Colors.black,
          ),
        ));
  }
}

class BigModule extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const BigModule(
      {required this.icon, required this.title, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height / 14;
    return InkWell(
      radius: 25,
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Color(0xffFFE427),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: size,
            ),
            Text(
              title,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmallModule extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const SmallModule(
      {required this.icon, required this.title, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height / 32;
    return InkWell(
      onTap: title == 'welcome_soon'.tr()
          ? null
          : () {
              onTap();
            },
      radius: 25,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Color(0xffFFE427),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: size,
            ),
            Text(
              title,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
