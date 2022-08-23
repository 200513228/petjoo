// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_viewmode.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsViewModel on SettingsViewModelBase, Store {
  late final _$logoutAsyncAction =
      AsyncAction('SettingsViewModelBase.logout', context: context);

  @override
  Future<dynamic> logout(BuildContext _) {
    return _$logoutAsyncAction.run(() => super.logout(_));
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
  String toString() {
    return '''

    ''';
  }
}
