// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BlogListViewModel on BlogListViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'BlogListViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$topicsAtom =
      Atom(name: 'BlogListViewModelBase.topics', context: context);

  @override
  List<BlogTopicModel> get topics {
    _$topicsAtom.reportRead();
    return super.topics;
  }

  @override
  set topics(List<BlogTopicModel> value) {
    _$topicsAtom.reportWrite(value, super.topics, () {
      super.topics = value;
    });
  }

  late final _$recoveryListAtom =
      Atom(name: 'BlogListViewModelBase.recoveryList', context: context);

  @override
  List<BlogTopicModel> get recoveryList {
    _$recoveryListAtom.reportRead();
    return super.recoveryList;
  }

  @override
  set recoveryList(List<BlogTopicModel> value) {
    _$recoveryListAtom.reportWrite(value, super.recoveryList, () {
      super.recoveryList = value;
    });
  }

  late final _$filterAtom =
      Atom(name: 'BlogListViewModelBase.filter', context: context);

  @override
  BlogFilterModel get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(BlogFilterModel value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  late final _$contAtom =
      Atom(name: 'BlogListViewModelBase.cont', context: context);

  @override
  TextEditingController get cont {
    _$contAtom.reportRead();
    return super.cont;
  }

  @override
  set cont(TextEditingController value) {
    _$contAtom.reportWrite(value, super.cont, () {
      super.cont = value;
    });
  }

  late final _$getTopicsAsyncAction =
      AsyncAction('BlogListViewModelBase.getTopics', context: context);

  @override
  Future<dynamic> getTopics() {
    return _$getTopicsAsyncAction.run(() => super.getTopics());
  }

  late final _$BlogListViewModelBaseActionController =
      ActionController(name: 'BlogListViewModelBase', context: context);

  @override
  void query(String query) {
    final _$actionInfo = _$BlogListViewModelBaseActionController.startAction(
        name: 'BlogListViewModelBase.query');
    try {
      return super.query(query);
    } finally {
      _$BlogListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFilter() {
    final _$actionInfo = _$BlogListViewModelBaseActionController.startAction(
        name: 'BlogListViewModelBase.resetFilter');
    try {
      return super.resetFilter();
    } finally {
      _$BlogListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(BlogFilterModel model) {
    final _$actionInfo = _$BlogListViewModelBaseActionController.startAction(
        name: 'BlogListViewModelBase.setFilter');
    try {
      return super.setFilter(model);
    } finally {
      _$BlogListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
topics: ${topics},
recoveryList: ${recoveryList},
filter: ${filter},
cont: ${cont}
    ''';
  }
}
