import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';

class Routes {
  static const String navigation = "navigation";
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    late Widget page;
    switch (routeSettings.name) {
      case navigation:
        // page = const NavigationView();
        page = WelcomeView();
        break;
    }
    log(routeSettings.name ?? "Unknown", name: "Route");
    return MaterialPageRoute(
        builder: (context) => page, settings: routeSettings);
  }
}
