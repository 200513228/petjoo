// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsViewModel on SettingsViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'SettingsViewModelBase.isLoading', context: context);

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

  late final _$logoutAsyncAction =
      AsyncAction('SettingsViewModelBase.logout', context: context);

  @override
  Future<dynamic> logout(BuildContext _) {
    return _$logoutAsyncAction.run(() => super.logout(_));
  }

  late final _$profilePicAsyncAction =
      AsyncAction('SettingsViewModelBase.profilePic', context: context);

  @override
  Future<dynamic> profilePic(BuildContext _) {
    return _$profilePicAsyncAction.run(() => super.profilePic(_));
  }

  late final _$SettingsViewModelBaseActionController =
      ActionController(name: 'SettingsViewModelBase', context: context);

  @override
  void navigate(BuildContext _, Widget page) {
    final _$actionInfo = _$SettingsViewModelBaseActionController.startAction(
        name: 'SettingsViewModelBase.navigate');
    try {
      return super.navigate(_, page);
    } finally {
      _$SettingsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void error(BuildContext _) {
    final _$actionInfo = _$SettingsViewModelBaseActionController.startAction(
        name: 'SettingsViewModelBase.error');
    try {
      return super.error(_);
    } finally {
      _$SettingsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$SettingsViewModelBaseActionController.startAction(
        name: 'SettingsViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$SettingsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
