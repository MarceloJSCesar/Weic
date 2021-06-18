import 'package:flutter/material.dart';
import 'package:weic/core/services/login_services.dart';
import '../../models/user.dart';
import '../../interfaces/auth_login/login_callback.dart';
import '../../services/auth_login/auth_login_response.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements LoginCallBack {
  String name, school;
  LoginServices _loginServices = LoginServices();
  LoginResponse _loginResponse;

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _LoginViewState() {
    _loginResponse = LoginResponse(this);
  }

  void _submit() {
    final _form = _formKey.currentState;

    if (_form.validate()) {
      setState(() {
        _isLoading = true;
        _form.save();
        _loginResponse.login(name, school);
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
          : SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text('Login'),
                      ),
                    ],
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
          await _loginServices.saveCacheData(user.id, user.name);
      if (savingDataValue == true) {
        setState(() {
          _isLoading = false;
        });
      } else {
        _showSnackBar('error when saving your data, re-open the app');
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      _showSnackBar('email and password invalid');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void onLoginError(String errorText) {
    _showSnackBar(errorText);
    setState(() {
      _isLoading = false;
    });
  }
}
