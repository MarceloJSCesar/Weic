// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$remenberMeAtom = Atom(name: '_LoginControllerBase.remenberMe');

  @override
  bool get remenberMe {
    _$remenberMeAtom.reportRead();
    return super.remenberMe;
  }

  @override
  set remenberMe(bool value) {
    _$remenberMeAtom.reportWrite(value, super.remenberMe, () {
      super.remenberMe = value;
    });
  }

  final _$emailAtom = Atom(name: '_LoginControllerBase.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginControllerBase.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$viewPasswordAtom = Atom(name: '_LoginControllerBase.viewPassword');

  @override
  bool get viewPassword {
    _$viewPasswordAtom.reportRead();
    return super.viewPassword;
  }

  @override
  set viewPassword(bool value) {
    _$viewPasswordAtom.reportWrite(value, super.viewPassword, () {
      super.viewPassword = value;
    });
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  void setRemenberMe(bool value) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.setRemenberMe');
    try {
      return super.setRemenberMe(value);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic saveValue(bool? isEmail, String? value) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.saveValue');
    try {
      return super.saveValue(isEmail, value);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void viewPasswordValue() {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.viewPasswordValue');
    try {
      return super.viewPasswordValue();
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
remenberMe: ${remenberMe},
email: ${email},
password: ${password},
viewPassword: ${viewPassword}
    ''';
  }
}
