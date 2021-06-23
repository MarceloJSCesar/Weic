import 'package:mobx/mobx.dart';

part 'auth_service.g.dart';

class AuthService = AuthServiceBase with _$AuthService;

abstract class AuthServiceBase with Store {
  @observable
  bool viewPassword = false;

  @action
  void viewPasswordValue() {
    viewPassword = !viewPassword;
  }
}
