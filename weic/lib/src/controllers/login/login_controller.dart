import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  FirebaseAuth auth = FirebaseAuth.instance;

  listenUserLogChanges() {
    auth.authStateChanges().listen(
      (user) {
        if (user == null) {
          print('user is logged out');
        } else {
          print('user is logged in');
        }
      },
    );
  }

  @observable
  bool isLoading = false;

  @action
  setToLoad() {
    isLoading = true;
  }

  @action
  setToUnload() {
    isLoading = false;
  }

  @observable
  bool remenberMe = false;

  @action
  void setRemenberMe(bool value) => remenberMe = value;

  @observable
  String? email, password = '';

  @observable
  bool viewPassword = true;

  @action
  saveValue(bool? isEmail, String? value) {
    if (isEmail == true) {
      email = value;
    } else {
      password = value;
    }
  }

  @action
  void viewPasswordValue() {
    viewPassword = !viewPassword;
  }

  String? validateEmail(String email) {
    if (email.trim().isEmpty || email.trim().length <= 10) {
      return 'email invalido';
    } else {
      return null;
    }
  }

  String? validatePassword(String password) {
    if (password.trim().isEmpty || password.trim().length < 8) {
      return 'password invalido, pelo menos 8 caracteres';
    } else {
      return null;
    }
  }
}
