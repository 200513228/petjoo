import 'package:flutter/material.dart';
import 'package:petjoo/modules/settings/viewmodel/settings_viewmode.dart';
import 'package:petjoo/modules/user/model/user_model.dart';
import 'package:petjoo/product/constants/images.dart';

class SettingsView extends StatelessWidget {
  final SettingsViewModel vm = SettingsViewModel();
  SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Scaffold(
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(flex: 3, child: userCard()),
          Expanded(flex: 5, child: settingsTiles()),
        ],
      ),
    );
  }

  Widget settingsTiles() {
    return Column(
      children: [
        settingTile('Profil', Icons.person, Container()),
        const SizedBox(height: 10),
        settingTile('Ayarlar', Icons.settings, Container()),
        const SizedBox(height: 10),
        settingTile('Çıkış Yap', Icons.power_settings_new_rounded, Container()),
      ],
    );
  }

  Widget settingTile(String title, IconData icon, Widget page) {
    return ListTile(
      style: ListTileStyle.list,
      visualDensity: VisualDensity.compact,
      leading: Icon(icon, color: Colors.white, size: 32),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: () {},
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white70,
      ),
    );
  }

  Widget userCard() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(builder: (context) {
            if (CurrentUser.image != '') {
              return Container(
                  clipBehavior: Clip.hardEdge,
                  width: 200,
                  height: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: Image.network(
                    CurrentUser.image,
                    fit: BoxFit.fitWidth,
                  ));
            } else {
              return Container(
                  clipBehavior: Clip.hardEdge,
                  width: 200,
                  height: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: Image.asset(
                    Images.noImage,
                    fit: BoxFit.fitWidth,
                  ));
            }
          }),
          Text(
            '${CurrentUser.name} ${CurrentUser.surname}',
            style: const TextStyle(fontSize: 30, color: Colors.black),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('AYARLAR'),
      centerTitle: true,
    );
  }
}
