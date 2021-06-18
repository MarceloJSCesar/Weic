import '../../interfaces/auth_login/login_callback.dart';
import '../../services/auth_login/auth_login_request.dart';

class LoginResponse {
  LoginCallBack _loginCallBack;
  LoginRequest _loginRequest = LoginRequest();

  LoginResponse(this._loginCallBack);

  login(String name, String school) {
    _loginRequest
        .login(name, school)
        .then((user) => _loginCallBack.onLoginSucess(user))
        .onError((error, stackTrace) =>
            _loginCallBack.onLoginError(error.toString()));
  }
}
