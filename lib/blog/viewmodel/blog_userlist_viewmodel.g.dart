// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_userlist_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BlogUserListViewModel on BlogUserListViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'BlogUserListViewModelBase.isLoading', context: context);

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
      Atom(name: 'BlogUserListViewModelBase.topics', context: context);

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

  late final _$getTopicsAsyncAction =
      AsyncAction('BlogUserListViewModelBase.getTopics', context: context);

  @override
  Future<dynamic> getTopics() {
    return _$getTopicsAsyncAction.run(() => super.getTopics());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
topics: ${topics}
    ''';
  }
}
