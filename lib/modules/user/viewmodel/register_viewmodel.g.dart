// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterViewModel on RegisterViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'RegisterViewModelBase.isLoading', context: context);

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

  late final _$formKeyAtom =
      Atom(name: 'RegisterViewModelBase.formKey', context: context);

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  late final _$emailContAtom =
      Atom(name: 'RegisterViewModelBase.emailCont', context: context);

  @override
  TextEditingController get emailCont {
    _$emailContAtom.reportRead();
    return super.emailCont;
  }

  @override
  set emailCont(TextEditingController value) {
    _$emailContAtom.reportWrite(value, super.emailCont, () {
      super.emailCont = value;
    });
  }

  late final _$passContAtom =
      Atom(name: 'RegisterViewModelBase.passCont', context: context);

  @override
  TextEditingController get passCont {
    _$passContAtom.reportRead();
    return super.passCont;
  }

  @override
  set passCont(TextEditingController value) {
    _$passContAtom.reportWrite(value, super.passCont, () {
      super.passCont = value;
    });
  }

  late final _$nameContAtom =
      Atom(name: 'RegisterViewModelBase.nameCont', context: context);

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

  late final _$surNameContAtom =
      Atom(name: 'RegisterViewModelBase.surNameCont', context: context);

  @override
  TextEditingController get surNameCont {
    _$surNameContAtom.reportRead();
    return super.surNameCont;
  }

  @override
  set surNameCont(TextEditingController value) {
    _$surNameContAtom.reportWrite(value, super.surNameCont, () {
      super.surNameCont = value;
    });
  }

  late final _$phoneContAtom =
      Atom(name: 'RegisterViewModelBase.phoneCont', context: context);

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

  late final _$dialCodeAtom =
      Atom(name: 'RegisterViewModelBase.dialCode', context: context);

  @override
  String? get dialCode {
    _$dialCodeAtom.reportRead();
    return super.dialCode;
  }

  @override
  set dialCode(String? value) {
    _$dialCodeAtom.reportWrite(value, super.dialCode, () {
      super.dialCode = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('RegisterViewModelBase.register', context: context);

  @override
  Future<dynamic> register(BuildContext context) {
    return _$registerAsyncAction.run(() => super.register(context));
  }

  late final _$RegisterViewModelBaseActionController =
      ActionController(name: 'RegisterViewModelBase', context: context);

  @override
  void navigate(BuildContext _, String asset) {
    final _$actionInfo = _$RegisterViewModelBaseActionController.startAction(
        name: 'RegisterViewModelBase.navigate');
    try {
      return super.navigate(_, asset);
    } finally {
      _$RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void successfull(BuildContext context) {
    final _$actionInfo = _$RegisterViewModelBaseActionController.startAction(
        name: 'RegisterViewModelBase.successfull');
    try {
      return super.successfull(context);
    } finally {
      _$RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void error(BuildContext context, String error) {
    final _$actionInfo = _$RegisterViewModelBaseActionController.startAction(
        name: 'RegisterViewModelBase.error');
    try {
      return super.error(context, error);
    } finally {
      _$RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
formKey: ${formKey},
emailCont: ${emailCont},
passCont: ${passCont},
nameCont: ${nameCont},
surNameCont: ${surNameCont},
phoneCont: ${phoneCont},
dialCode: ${dialCode}
    ''';
  }
}
