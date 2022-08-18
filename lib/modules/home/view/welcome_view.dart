import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/modules/base/color_palette.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/home/viewmodel/welcome_viewmodel.dart';
import 'package:petjoo/modules/settings/view/settings_view.dart';
import 'package:petjoo/modules/user/model/current_user.dart';
import 'package:petjoo/modules/user/view/login_view.dart';

class WelcomeView extends StatelessWidget {
  final WelcomeViewModel vm = WelcomeViewModel();
  WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.userLogin();
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(flex: 6, child: slider()),
            Expanded(flex: 4, child: selector(context)),
            userCard(context),
            const SizedBox(height: 0)
          ],
        ),
      ),
    );
  }

  Widget slider() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
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
                child: bigButton(_, Icons.pets, 'PET'),
              ),
              Expanded(
                flex: 6,
                child: smallButton(_, FontAwesomeIcons.userDoctor, 'VETERİNER'),
              ),
            ],
          )),
          Expanded(
              child: Column(
            children: [
              Expanded(
                flex: 6,
                child: smallButton(_, FontAwesomeIcons.truck, 'PET NAKİL'),
              ),
              Expanded(
                flex: 10,
                child: bigButton(_, Icons.store, 'PAZAR'),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget bigButton(BuildContext _, IconData icon, String title) {
    return InkWell(
      radius: 25,
      onTap: () {
        vm.goModule(_, title);
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
              size: 64,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget smallButton(BuildContext _, IconData icon, String title) {
    return InkWell(
      onTap: title == 'VETERİNER'
          ? null
          : () {
              vm.goModule(_, title);
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
              size: 32,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userCard(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 19),
        child: ListTile(
          tileColor: const Color(0xffFFE427),
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
              ? CircleAvatar(
                  child:
                      Text(CurrentUser.name != '' ? CurrentUser.name[0] : ''),
                )
              : const CircleAvatar(),
          title: vm.userLog
              ? Text(CurrentUser.name)
              : const Text('Giriş Yapmak İçin Tıklayınız'),
          trailing: Image.asset('assets/images/logo.png'),
        ),
      );
    });
  }
}
