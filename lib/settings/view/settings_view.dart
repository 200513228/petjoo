import 'package:badges/badges.dart' as badges;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/settings/view/documents_view.dart';
import 'package:petjoo/settings/view/profile_view.dart';
import 'package:petjoo/settings/viewmodel/settings_viewmodel.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:petjoo/constants/images.dart';

class SettingsView extends StatelessWidget {
  final SettingsViewModel vm = SettingsViewModel();
  SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                userCard(context),
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
        settingTile('settings_profile'.tr(), Icons.person,
            () => vm.navigate(_, ProfileView())),
        if (CurrentUser.hasTransport)
          settingTile('settings_transport'.tr(), FontAwesomeIcons.truck,
              () => vm.transportNavigate(_)),
        settingTile('settings_docs'.tr(), Icons.file_open,
            () => vm.navigate(_, const DocumentsView())),
        // settingTile('Ayarlar', Icons.settings, Container(), () {}),
        settingTile('settings_out'.tr(), Icons.power_settings_new_rounded,
            () => vm.logout(_)),
      ],
    );
  }

  Widget settingTile(String title, IconData icon, Function ontap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        style: ListTileStyle.list,
        visualDensity: VisualDensity.compact,
        leading: Icon(icon, color: Colors.white, size: 28),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        onTap: () => ontap(),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget userCard(BuildContext _) {
    return Align(
      alignment: Alignment.center,
      child: Observer(builder: (_) {
        return vm.isLoading
            ? const Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  badges.Badge(
                    badgeContent: const Icon(Icons.camera_alt),
                    position:
                        badges.BadgePosition.bottomEnd(end: 16, bottom: 10),
                    badgeColor: Colors.black54,
                    child: InkWell(
                      onTap: () {
                        vm.profilePic(_);
                      },
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
              );
      }),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      title: Text('settings_title'.tr()),
      centerTitle: true,
    );
  }
}
