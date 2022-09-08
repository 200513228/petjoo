// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelBase, Store {
  late final _$currentPageAtom =
      Atom(name: 'HomeViewModelBase.currentPage', context: context);

  @override
  Widget get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(Widget value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: 'HomeViewModelBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$chatCountAtom =
      Atom(name: 'HomeViewModelBase.chatCount', context: context);

  @override
  int get chatCount {
    _$chatCountAtom.reportRead();
    return super.chatCount;
  }

  @override
  set chatCount(int value) {
    _$chatCountAtom.reportWrite(value, super.chatCount, () {
      super.chatCount = value;
    });
  }

  late final _$getChatCountAsyncAction =
      AsyncAction('HomeViewModelBase.getChatCount', context: context);

  @override
  Future<dynamic> getChatCount() {
    return _$getChatCountAsyncAction.run(() => super.getChatCount());
  }

  late final _$HomeViewModelBaseActionController =
      ActionController(name: 'HomeViewModelBase', context: context);

  @override
  void swithPage(Widget page, int x) {
    final _$actionInfo = _$HomeViewModelBaseActionController.startAction(
        name: 'HomeViewModelBase.swithPage');
    try {
      return super.swithPage(page, x);
    } finally {
      _$HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void navigate(BuildContext context, Widget page, bool pop) {
    final _$actionInfo = _$HomeViewModelBaseActionController.startAction(
        name: 'HomeViewModelBase.navigate');
    try {
      return super.navigate(context, page, pop);
    } finally {
      _$HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
currentIndex: ${currentIndex},
chatCount: ${chatCount}
    ''';
  }
}
