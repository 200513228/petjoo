import 'package:flutter/material.dart';

class PageNotifier extends ChangeNotifier {
  PageNotifier(this.context);

  final BuildContext context;
  bool isLoading = false;

  void changeLoading([bool? value]) {
    isLoading = value ?? !isLoading;
    notifyListeners();
  }
}
