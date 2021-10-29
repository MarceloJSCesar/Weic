import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  bool isPasswordVisible = false;

  @action
  void setPasswordVisible() {
    isPasswordVisible = true;
  }

  @action
  void setPasswordObscure() {
    isPasswordVisible = false;
  }
}
