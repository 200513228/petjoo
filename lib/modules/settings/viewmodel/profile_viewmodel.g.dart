// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileViewModel on ProfileViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ProfileViewModelBase.isLoading', context: context);

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

  late final _$dialCodeAtom =
      Atom(name: 'ProfileViewModelBase.dialCode', context: context);

  @override
  String get dialCode {
    _$dialCodeAtom.reportRead();
    return super.dialCode;
  }

  @override
  set dialCode(String value) {
    _$dialCodeAtom.reportWrite(value, super.dialCode, () {
      super.dialCode = value;
    });
  }

  late final _$phoneContAtom =
      Atom(name: 'ProfileViewModelBase.phoneCont', context: context);

  @override
  TextEditingController get phoneCont {
    _$phoneContAtom.reportRead();
    return super.phoneCont;
  }

  @override
  set phoneCont(TextEditingController value) {
    _$phoneContAtom.reportWrite(value, super.phoneCont, () {
      super.phoneCont = value;
    });
  }

  late final _$nameContAtom =
      Atom(name: 'ProfileViewModelBase.nameCont', context: context);

  @override
  TextEditingController get nameCont {
    _$nameContAtom.reportRead();
    return super.nameCont;
  }

  @override
  set nameCont(TextEditingController value) {
    _$nameContAtom.reportWrite(value, super.nameCont, () {
      super.nameCont = value;
    });
  }

  late final _$surnameContAtom =
      Atom(name: 'ProfileViewModelBase.surnameCont', context: context);

  @override
  TextEditingController get surnameCont {
    _$surnameContAtom.reportRead();
    return super.surnameCont;
  }

  @override
  set surnameCont(TextEditingController value) {
    _$surnameContAtom.reportWrite(value, super.surnameCont, () {
      super.surnameCont = value;
    });
  }

  late final _$saveAsyncAction =
      AsyncAction('ProfileViewModelBase.save', context: context);

  @override
  Future<dynamic> save(BuildContext context) {
    return _$saveAsyncAction.run(() => super.save(context));
  }

  late final _$deleteAsyncAction =
      AsyncAction('ProfileViewModelBase.delete', context: context);

  @override
  Future<dynamic> delete(BuildContext _) {
    return _$deleteAsyncAction.run(() => super.delete(_));
  }

  late final _$ProfileViewModelBaseActionController =
      ActionController(name: 'ProfileViewModelBase', context: context);

  @override
  void error(BuildContext _, String data) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase.error');
    try {
      return super.error(_, data);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
dialCode: ${dialCode},
phoneCont: ${phoneCont},
nameCont: ${nameCont},
surnameCont: ${surnameCont}
    ''';
  }
}
