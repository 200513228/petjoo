import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/repositories/advert_repository.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_list_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_list_view.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/network/requests.dart';
import '../extra/extra_view.dart';

class NavigationViewModel extends PageNotifier {
  NavigationViewModel(super.context, this._advertRepository);

  final AdvertRepository _advertRepository;
  int index = 1;
  final PageController pageController = PageController(initialPage: 1);
  bool? hasTransport;
  List<Widget> pages = const [
    TransportAdvertListView(),
    AdvertListView(),
    ExtraView(),
    AdvertListView(),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void jumpToPage(value) {
    if (pageController.hasClients) {
      index = value;
      notifyListeners();
      pageController.jumpToPage(value);
    }
  }

  void logout() {
    Requests.removeUserFcm(FirebaseAuth.instance.currentUser!.uid);
    FirebaseAuth.instance.signOut();
    context.pushReplacementNamed(Routes.auth);
  }

  checkDynamicLink(PendingDynamicLinkData linkData) {
    changeLoading();
    _advertRepository
        .getAdvert(linkData.link.query.split('=').last)
        .then((value) {
      Navigator.pushNamed(context, "navigation${linkData.link.path}",
          arguments: value);
      changeLoading();
    });
  }
}
