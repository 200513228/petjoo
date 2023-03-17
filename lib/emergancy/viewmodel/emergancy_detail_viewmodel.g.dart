// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergancy_detail_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmergancyDetailViewModel on EmergancyDetailViewModelBase, Store {
  late final _$currentPageAtom =
      Atom(name: 'EmergancyDetailViewModelBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$contAtom =
      Atom(name: 'EmergancyDetailViewModelBase.cont', context: context);

  @override
  PageController get cont {
    _$contAtom.reportRead();
    return super.cont;
  }

  @override
  set cont(PageController value) {
    _$contAtom.reportWrite(value, super.cont, () {
      super.cont = value;
    });
  }

  late final _$EmergancyDetailViewModelBaseActionController =
      ActionController(name: 'EmergancyDetailViewModelBase', context: context);

  @override
  void newPage(int i) {
    final _$actionInfo = _$EmergancyDetailViewModelBaseActionController
        .startAction(name: 'EmergancyDetailViewModelBase.newPage');
    try {
      return super.newPage(i);
    } finally {
      _$EmergancyDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
cont: ${cont}
    ''';
  }
}
