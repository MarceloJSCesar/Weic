import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../storage/db_storage.dart';
import '../../views/home/home_view.dart';
import '../../config/app_textstyles.dart';
import '../../config/app_decorations.dart';
import '../../config/app_assets_names.dart';
import '../../services/login_services.dart';
import '../../../core/config/app_colors.dart';
import '../../components/text_form_field_component.dart';
import '../../interfaces/auth_login/login_callback.dart';
import '../../services/auth_login/auth_login_response.dart';
import '../../../core/controllers/auth_services/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements LoginCallBack {
  String email, password;
  LoginServices _loginServices = LoginServices();
  LoginResponse _loginResponse;
  AuthService _auth = AuthService();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _LoginViewState() {
    _loginResponse = LoginResponse(this);
  }

  _submit() {
    // implement validation after
    final _form = _formKey.currentState;

    if (_form.validate() && email.length > 10 && password.length > 8) {
      setState(() {
        _isLoading = true;
        _form.save();
        _loginResponse.login(email, password);
      });
    }
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(text),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    // DbStorage db = DbStorage();
    // db.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 3.0,
              ),
            )
          : Container(
              decoration: AppDecorations.mainDecoration,
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        ClipOval(
                          child: Image(
                            width: 300,
                            image: AssetImage(AppAssetsNames.logoImageUrl),
                          ),
                        ),
                        Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.black,
                          shadowColor: Colors.black,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 40,
                            ),
                            child: Column(
                              children: <Widget>[
                                TextFormFieldComponent(
                                  hintText: 'Email',
                                  saveValue: (val) => email = val,
                                  isPasswordField: false,
                                  isEmailField: true,
                                  validateField: (val) =>
                                      _auth.validateEmail(val),
                                ),
                                Divider(),
                                TextFormFieldComponent(
                                  hintText: 'Password',
                                  saveValue: (val) => password = val,
                                  isPasswordField: true,
                                  isEmailField: false,
                                  validateField: (val) =>
                                      _auth.validatePassword(val),
                                  showPassword: () => setState(() {
                                    _auth.viewPasswordValue();
                                  }),
                                  obscureText: () {
                                    if (_auth.viewPassword == true) {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  },
                                  viewPassword: _auth.viewPassword,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      AppColors.mainPrefixColor,
                                    ),
                                  ),
                                  onPressed: _submit,
                                  child: Text('Entrar'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  child: Text(
                                    'Nao tenho uma conta, Registrar',
                                    style: AppTextStyles.hintTextStyle,
                                  ),
                                  onTap: () => Navigator.of(context)
                                      .pushReplacementNamed('/register'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void onLoginSucess(User user) async {
    if (user != null) {
      bool savingDataValue =
          await _loginServices.saveCacheData(user.email, user.password);
      if (savingDataValue == true) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => HomeView()));
      } else {
        _showSnackBar('error when saving your data, re-open the app');
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      _showSnackBar('email and password invalido');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void onLoginError(String errorText) {
    _showSnackBar(errorText);
    print(errorText);
    setState(() {
      _isLoading = false;
    });
  }
}
