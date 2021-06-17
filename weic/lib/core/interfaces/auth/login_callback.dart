import '../../models/user.dart';

abstract class LoginCallBack {
  void onLoginSucess(User user) {}
  void onLoginError(String error) {}
}
