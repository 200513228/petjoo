import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/blog/view/blog_list_view.dart';
import 'package:petjoo/emergancy/view/emergancy_list_view.dart';
import 'package:petjoo/home/service/dlink_service.dart';
import 'package:petjoo/home/service/notification_service.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/home/viewmodel/welcome_viewmodel.dart';
import 'package:petjoo/settings/view/settings_view.dart';
import 'package:petjoo/ui/please_auth.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:petjoo/user/view/login_view.dart';
import 'package:petjoo/constants/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeView extends StatelessWidget {
  final WelcomeViewModel vm = WelcomeViewModel();
  WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black);
    vm.userLogin(context);
    vm.checkBan();
    DLinkService.isGo ? vm.navDLink(context) : null;
    NotificationService.isGo ? vm.navNotf(context) : null;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPalette['primary'],
          title: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: PopupMenuButton(
                      color: Colors.black,
                      iconSize: 18,
                      padding: const EdgeInsets.all(4),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: () =>
                                  context.setLocale(const Locale('tr')),
                              child: Text('welcome_lang_tr'.tr()),
                            ),
                            PopupMenuItem(
                              onTap: () =>
                                  context.setLocale(const Locale('en')),
                              child: Text('welcome_lang_en'.tr()),
                            ),
                            PopupMenuItem(
                              onTap: () =>
                                  context.setLocale(const Locale('de')),
                              child: Text('welcome_lang_de'.tr()),
                            ),
                          ],
                      child: Row(
                        children: [
                          const Icon(
                            Icons.translate,
                            color: Colors.black,
                          ),
                          Text('Language', style: style)
                        ],
                      ))),
              Expanded(
                flex: 4,
                child: TextButton(
                    onPressed: () {
                      launchUrl(Uri(
                          scheme: 'https',
                          host: 'instabio.cc',
                          path: '40322174EAGUB'));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.black,
                        ),
                        Text(
                          'social'.tr(),
                          style: style,
                        ),
                      ],
                    )),
              ),
              Expanded(
                flex: 3,
                child: TextButton(
                    onPressed: () {
                      launchUrl(Uri(
                          scheme: 'https',
                          host: 'wa.me',
                          path: '905308327111'));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.whatsapp,
                          color: Colors.black,
                        ),
                        Text(
                          'contact'.tr(),
                          style: style,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        backgroundColor: colorPalette['secondary'],
        body: Observer(
          builder: (context) {
            // return vm.hasBan
            //     ? showBanned(context)
            //     :
            return (vm.isLoading
                ? const Loading()
                : Column(
                    children: [
                      Expanded(flex: 6, child: slider()),
                      Expanded(flex: 11, child: selector(context)),
                      userCard(context),
                    ],
                  ));
          },
        ));
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
      padding: const EdgeInsets.all(15),
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
                  icon: Icons.forum,
                  title: 'welcome_blog'.tr(),
                  onTap: () => Navigator.push(_,
                      MaterialPageRoute(builder: (context) => BlogListView())),
                ),
              ),
              Expanded(
                flex: 6,
                child: SmallModule(
                  icon: FontAwesomeIcons.solidHospital,
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
              Expanded(
                flex: 6,
                child: SmallModule(
                  icon: Icons.warning_rounded,
                  title: 'welcome_emergancy'.tr(),
                  onTap: () => Navigator.push(
                      _,
                      MaterialPageRoute(
                          builder: (context) => EmergancyListView())),
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
              CurrentUser.hasBan
                  ? showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const YouRBanned())
                  : (vm.userLog
                      ? Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => SettingsView()),
                          (route) => true,
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginView())));
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
        iconSize: 18,
        padding: const EdgeInsets.all(4),
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
        child: const Icon(
          Icons.translate,
          color: Colors.black,
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
        CurrentUser.hasBan
            ? showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const YouRBanned())
            : onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(5),
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
              CurrentUser.hasBan
                  ? showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const YouRBanned())
                  : onTap();
            },
      radius: 25,
      child: Container(
        margin: const EdgeInsets.all(5),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: title == 'welcome_emergancy'.tr()
              ? Colors.red
              : title == 'welcome_soon'.tr()
                  ? const Color(0xffFFE427).withOpacity(0.68)
                  : const Color(0xffFFE427),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.black,
                  size: icon.runtimeType.toString() == 'IconData'
                      ? size * (3 / 2)
                      : size,
                ),
                // Text(
                //   title,
                //   maxLines: 1,
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(
                //     fontSize: 20,
                //     color: Colors.black,
                //     fontWeight: FontWeight.bold,
                //     letterSpacing: -1.5,
                //     // decoration: TextDecoration.lineThrough,
                //   ),
                // ),
                Badge(
                  showBadge: title == 'welcome_soon'.tr(),
                  badgeColor: Colors.transparent,
                  position: BadgePosition.bottomEnd(bottom: -25, end: 11),
                  badgeContent: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.65),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      'soon'.tr(),
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: Text(
                    title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                      // decoration: TextDecoration.lineThrough,
                    ),
                  ),
                )
              ],
            ),
            // if (title == 'welcome_soon'.tr())
            //   Container(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 3, horizontal: 18),
            //     child: Center(
            //       child: Transform(
            //         alignment: FractionalOffset.center,
            //         transform: Matrix4.identity()
            //           ..rotateZ(-20 * 3.1415927 / 180),
            //         child: Container(
            //           decoration: BoxDecoration(
            //               color: Colors.red.withOpacity(0.65),
            //               borderRadius:
            //                   const BorderRadius.all(Radius.circular(8))),
            //           child: Text(
            //             'soon'.tr(),
            //             textAlign: TextAlign.center,
            //             style: const TextStyle(
            //               fontSize: 24,
            //               // color: Colors.redAccent,
            //               letterSpacing: 5,
            //               color: Colors.white,
            //               // foreground: Paint()
            //               //   ..style = PaintingStyle.fill
            //               //   ..style = PaintingStyle.stroke
            //               //   ..strokeWidth = 2
            //               //   ..color = Colors.black,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
