// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WelcomeViewModel on WelcomeViewModelBase, Store {
  late final _$userLogAtom =
      Atom(name: 'WelcomeViewModelBase.userLog', context: context);

  @override
  bool get userLog {
    _$userLogAtom.reportRead();
    return super.userLog;
  }

  @override
  set userLog(bool value) {
    _$userLogAtom.reportWrite(value, super.userLog, () {
      super.userLog = value;
    });
  }

  late final _$userLoginAsyncAction =
      AsyncAction('WelcomeViewModelBase.userLogin', context: context);

  @override
  Future<dynamic> userLogin() {
    return _$userLoginAsyncAction.run(() => super.userLogin());
  }

  @override
  String toString() {
    return '''
userLog: ${userLog}
    ''';
  }
}