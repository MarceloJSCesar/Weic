import '../../interfaces/auth_login/login_callback.dart';
import '../../services/auth_login/auth_login_request.dart';

class LoginResponse {
  LoginCallBack _loginCallBack;
  LoginRequest _loginRequest = LoginRequest();

  LoginResponse(this._loginCallBack);

  login(String email, String password) {
    _loginRequest
        .login(email.trim(), password.trim())
        .then((user) => _loginCallBack.onLoginSucess(user))
        .catchError((error, stackTrace) =>
            _loginCallBack.onLoginError(error.toString()));
  }
}
