// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
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
viewPassword: ${viewPassword}
    ''';
  }
}
