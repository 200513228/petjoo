// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginViewModel on LoginViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'LoginViewModelBase.isLoading', context: context);

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

  late final _$obscPassAtom =
      Atom(name: 'LoginViewModelBase.obscPass', context: context);

  @override
  bool get obscPass {
    _$obscPassAtom.reportRead();
    return super.obscPass;
  }

  @override
  set obscPass(bool value) {
    _$obscPassAtom.reportWrite(value, super.obscPass, () {
      super.obscPass = value;
    });
  }

  late final _$emailContAtom =
      Atom(name: 'LoginViewModelBase.emailCont', context: context);

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
      Atom(name: 'LoginViewModelBase.passCont', context: context);

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

  late final _$loginAsyncAction =
      AsyncAction('LoginViewModelBase.login', context: context);

  @override
  Future<dynamic> login(BuildContext _) {
    return _$loginAsyncAction.run(() => super.login(_));
  }

  late final _$forgotPassAsyncAction =
      AsyncAction('LoginViewModelBase.forgotPass', context: context);

  @override
  Future<dynamic> forgotPass(BuildContext _) {
    return _$forgotPassAsyncAction.run(() => super.forgotPass(_));
  }

  late final _$LoginViewModelBaseActionController =
      ActionController(name: 'LoginViewModelBase', context: context);

  @override
  void changeObsc() {
    final _$actionInfo = _$LoginViewModelBaseActionController.startAction(
        name: 'LoginViewModelBase.changeObsc');
    try {
      return super.changeObsc();
    } finally {
      _$LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void succesful(BuildContext _) {
    final _$actionInfo = _$LoginViewModelBaseActionController.startAction(
        name: 'LoginViewModelBase.succesful');
    try {
      return super.succesful(_);
    } finally {
      _$LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void succesfulPass(BuildContext _) {
    final _$actionInfo = _$LoginViewModelBaseActionController.startAction(
        name: 'LoginViewModelBase.succesfulPass');
    try {
      return super.succesfulPass(_);
    } finally {
      _$LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void error(BuildContext context, String value) {
    final _$actionInfo = _$LoginViewModelBaseActionController.startAction(
        name: 'LoginViewModelBase.error');
    try {
      return super.error(context, value);
    } finally {
      _$LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void errorPass(BuildContext context, String value) {
    final _$actionInfo = _$LoginViewModelBaseActionController.startAction(
        name: 'LoginViewModelBase.errorPass');
    try {
      return super.errorPass(context, value);
    } finally {
      _$LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void createAcc(BuildContext _) {
    final _$actionInfo = _$LoginViewModelBaseActionController.startAction(
        name: 'LoginViewModelBase.createAcc');
    try {
      return super.createAcc(_);
    } finally {
      _$LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
obscPass: ${obscPass},
emailCont: ${emailCont},
passCont: ${passCont}
    ''';
  }
}
