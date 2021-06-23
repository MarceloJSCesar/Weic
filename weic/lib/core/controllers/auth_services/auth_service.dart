import 'package:mobx/mobx.dart';

part 'auth_service.g.dart';

class AuthService = AuthServiceBase with _$AuthService;

abstract class AuthServiceBase with Store {
  @observable
  bool viewPassword = true;

  @action
  void viewPasswordValue() {
    viewPassword = !viewPassword;
    print(viewPassword);
  }

  String validateEmail(String email) {
    if (email.isEmpty || email.length <= 10) {
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
    if (password.isEmpty || password.length < 8) {
      return 'password invalido, pelo menos 8 caracteres';
    } else {
      return null;
    }
  }

  String validateSchool(String school) {
    if (school.isEmpty) {
      return 'nome da escola invalido';
    } else {
      return null;
    }
  }
}
