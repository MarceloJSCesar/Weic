import 'package:mobx/mobx.dart';

part 'auth_service.g.dart';

class AuthService = AuthServiceBase with _$AuthService;

abstract class AuthServiceBase with Store {
  @observable
  bool viewPassword = true;

  @action
  void viewPasswordValue() {
    viewPassword = !viewPassword;
  }

  String validateEmail(String email) {
    if (email.trim().isEmpty || email.trim().length <= 10) {
      return 'email invalido';
    } else {
      return null;
    }
  }

  String validateName(String name) {
    if (name.isEmpty || name.length < 8) {
      return 'nome invalido';
    } else {
      return null;
    }
  }

  String validatePassword(String password) {
    if (password.trim().isEmpty || password.trim().length < 8) {
      return 'password invalido, pelo menos 8 caracteres';
    } else {
      return null;
    }
  }

  String validateSchool(String school) {
    if (school.isEmpty && school.length < 2) {
      return 'nome da escola invalido';
    } else {
      return null;
    }
  }
}
