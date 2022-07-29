import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/routes.dart';

class TutorialViewModel extends PageNotifier {
  TutorialViewModel(BuildContext context) : super(context);

  final PageController pageController = PageController();
  int pageIndex = 0;

  bool get isLastPage => pageIndex == 4;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (isLastPage) {
      context.pushReplacementNamed(Routes.auth);
      return;
    }
    pageController.animateToPage(pageIndex, duration: const Duration(milliseconds: 200), curve: Curves.ease);
    pageIndex++;
    notifyListeners();
  }
}
