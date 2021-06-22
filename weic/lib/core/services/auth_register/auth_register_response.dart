import '../../models/user.dart';
import '../../services/auth_register/auth_register_request.dart';
import '../../interfaces/auth_register/register_callback.dart';

class RegisterResponse {
  RegisterCallBack _loginCallBack;
  RegisterRequest _registerRequest;

  void register(User user) {
    _registerRequest
        .register(user)
        .then((userId) => _loginCallBack.onRegisterSucess(userId))
        .catchError((errorText, stackTrace) =>
            _loginCallBack.onRegisterErrorText(errorText));
  }
}
