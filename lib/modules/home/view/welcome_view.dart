import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/modules/base/color_palette.dart';
import 'package:petjoo/modules/home/viewmodel/welcome_viewmodel.dart';
import 'package:petjoo/modules/settings/view/settings_view.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
import 'package:petjoo/modules/user/view/login_view.dart';
import 'package:petjoo/product/constants/images.dart';

class WelcomeView extends StatelessWidget {
  final WelcomeViewModel vm = WelcomeViewModel();
  WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.userLogin();
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Scaffold(
        backgroundColor: colorPalette['secondary'],
        body: Column(
          children: [
            Expanded(flex: 6, child: slider()),
            Expanded(flex: 4, child: selector(context)),
            userCard(context),
          ],
        ),
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
                  title: 'İLANLAR',
                  onTap: () => vm.goModule(_, 'İLANLAR'),
                ),
              ),
              Expanded(
                flex: 6,
                child: SmallModule(
                  icon: FontAwesomeIcons.compassDrafting,
                  title: 'YAKINDA',
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
                  title: 'PET NAKİL',
                  onTap: () => vm.goModule(_, 'PET NAKİL'),
                ),
              ),
              Expanded(
                flex: 10,
                child: BigModule(
                  icon: Icons.store,
                  title: 'PAZAR',
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
                        'Hoşgeldin, ${CurrentUser.name}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      )
                    : const Text('Giriş Yapmak İçin Tıklayınız',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
            trailing: const Icon(
              Icons.settings,
              size: 28,
              color: Colors.black,
            )),
      );
    });
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
      onTap: title == 'YAKINDA'
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
