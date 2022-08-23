import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/modules/settings/view/documents_view.dart';
import 'package:petjoo/modules/settings/view/profile_view.dart';
import 'package:petjoo/modules/settings/viewmodel/settings_viewmode.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                userCard(),
                const SizedBox(height: 20),
                settingsTiles(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget settingsTiles(BuildContext _) {
    return Column(
      children: [
        settingTile('Profil', Icons.person, Container(),
            () => vm.navigate(_, ProfileView())),
        const SizedBox(height: 10),
        settingTile('Belgeler', Icons.file_open, Container(),
            () => vm.navigate(_, const DocumentsView())),
        // const SizedBox(height: 10),
        // settingTile('Ayarlar', Icons.settings, Container(), () {}),
        const SizedBox(height: 10),
        settingTile('Çıkış Yap', Icons.power_settings_new_rounded, Container(),
            () {
          vm.logout(_);
        }),
      ],
    );
  }

  Widget settingTile(String title, IconData icon, Widget page, Function ontap) {
    return ListTile(
      style: ListTileStyle.list,
      visualDensity: VisualDensity.compact,
      leading: Icon(icon, color: Colors.white, size: 32),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: () => ontap(),
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
          Badge(
            badgeContent: const Icon(Icons.camera_alt),
            position: BadgePosition.bottomEnd(end: 16, bottom: 10),
            badgeColor: Colors.black54,
            child: InkWell(
              child: Builder(builder: (context) {
                if (CurrentUser.image != '') {
                  return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          CurrentUser.image,
                          fit: BoxFit.cover,
                        ),
                      ));
                } else {
                  return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          Images.noImage,
                          fit: BoxFit.fitWidth,
                        ),
                      ));
                }
              }),
            ),
          ),
          Text(
            '${CurrentUser.name} ${CurrentUser.surname}',
            style: const TextStyle(fontSize: 23, color: Colors.black),
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
