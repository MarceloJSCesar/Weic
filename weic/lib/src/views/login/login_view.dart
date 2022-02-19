import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weic/src/components/login/body/login_body.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/services/login/login_services.dart';
import '../../config/app_colors.dart';
import '../../controllers/login/login_controller.dart';
import '../../services/home/home_services.dart';
import '../app_view.dart';
import '../dados_essencial/dados_essencial_view.dart';

class LoginView extends StatefulWidget {
  static const String loginViewKey = 'loginViewKey';
  LoginView({Key? key}) : super(key: key);
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isPasswordVisible = false;
  final _loginServices = LoginServices();
  final _loginController = LoginController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginController.listenUserLogChanges();
  }

  bool? validateFields() {
    if (_emailController.text.isEmpty ||
        _emailController.text.trim().length <= 10 ||
        _passwordController.text.isEmpty ||
        _passwordController.text.trim().length < 8) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: LoginBody(
                        emailController: _emailController,
                        isPasswordVisible: _isPasswordVisible,
                        passwordController: _passwordController,
                        onPasswordVisibilityToggle: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                          print(_isPasswordVisible);
                        },
                        loginController: _loginController,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Observer(
                    builder: (_) {
                      return _loginController.isLoading == false
                          ? GestureDetector(
                              onTap: () async => validateFields() == true
                                  ? {
                                      _loginController.setToLoad(),
                                      print(
                                          'email: ${_emailController.text}, password: ${_passwordController.text}'),
                                      await _loginServices
                                          .login(
                                        _emailController.text,
                                        _passwordController.text,
                                      )
                                          .then(
                                        (value) async {
                                          if (value != null) {
                                            final _prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await _prefs.setString(
                                              'STUDENT_ID',
                                              value.id as String,
                                            );
                                            _loginServices.saveLoginState(
                                                _loginController.remenberMe);
                                            await HomeServices()
                                                .getStudentEssentialData(
                                              studentID: value.id as String,
                                            )
                                                .then((data) {
                                              if (data == null) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        DadosEssenciaisView(
                                                      student: value,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (_) => AppView(
                                                        studentID:
                                                            value.id as String),
                                                  ),
                                                );
                                              }
                                            });
                                          } else {
                                            _loginServices.showLoginMsgError(
                                                context: context);
                                          }
                                        },
                                      ),
                                      _loginController.setToUnload(),
                                    }
                                  : (context) => _loginServices
                                      .showLoginMsgError(context: context),
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF03989e),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Entrar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : CircularProgressIndicator(
                              color: AppColors.mainPrefixColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.mainPrefixColor,
                              ),
                              strokeWidth: 3.0,
                            );
                    },
                  ),
                  Expanded(child: Container()),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'WEIC v1.0',
                      style: AppTextStyles.chatTabTitleTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
