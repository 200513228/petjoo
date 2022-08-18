import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/home/viewmodel/welcome_viewmodel.dart';
import 'package:petjoo/modules/settings/view/settings_view.dart';
import 'package:petjoo/modules/user/model/user_model.dart';
import 'package:petjoo/presentation/auth/view/auth_view.dart';

class WelcomeView extends StatelessWidget {
  final WelcomeViewModel vm = WelcomeViewModel();
  WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.userLogin();
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(flex: 5, child: slider()),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  goButton(context, 'Pet İlanları'),
                  goButton(context, 'Pazar İlanları'),
                  goButton(context, 'Pet Nakil İlanları'),
                ],
              ),
            ),
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
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(38))),
    );
  }

  Widget userCard(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 19),
        child: ListTile(
            onTap: () {
              vm.userLog
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => SettingsView()),
                      (route) => true,
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthView()));
            },
            leading: vm.userLog
                ? CircleAvatar(
                    child:
                        Text(CurrentUser.name != '' ? CurrentUser.name[0] : ''),
                  )
                : const CircleAvatar(),
            title: vm.userLog
                ? Text(CurrentUser.name)
                : const Text('Giriş Yapmak İçin Tıklayınız')),
      );
    });
  }

  Widget goButton(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 70))),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeView(title: title)),
                    (route) => false);
              },
              child: Text(title)),
        ),
      ],
    );
  }
}
