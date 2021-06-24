// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthService on AuthServiceBase, Store {
  final _$viewPasswordAtom = Atom(name: 'AuthServiceBase.viewPassword');

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

  final _$AuthServiceBaseActionController =
      ActionController(name: 'AuthServiceBase');

  @override
  void viewPasswordValue() {
    final _$actionInfo = _$AuthServiceBaseActionController.startAction(
        name: 'AuthServiceBase.viewPasswordValue');
    try {
      return super.viewPasswordValue();
    } finally {
      _$AuthServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
viewPassword: ${viewPassword}
    ''';
  }
}
