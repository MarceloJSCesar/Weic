import 'package:flutter/material.dart';
import 'package:weic/core/components/register/widgets/register_card_widget.dart';
import 'package:weic/core/services/register_services.dart';
import '../../models/user.dart';
import '../../config/app_decorations.dart';
import '../../services/register_services.dart';
import '../../config/app_assets_names.dart';
import '../../interfaces/auth_login/login_callback.dart';
import '../../services/auth_register/auth_register_response.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> implements LoginCallBack {
  User user;

  String name, school, sexualitiy;
  RegisterResponse _registerResponse;
  RegisterServices _registerServices = RegisterServices();

  bool _isLoading = false;

  // String _sexualitySelected;
  // final _sexualities = ['Masculino', 'Femenino'];

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _RegisterViewState() {
    _registerResponse = RegisterResponse();
  }

  void _submit() {
    final _form = _formKey.currentState;

    if (_form.validate()) {
      setState(() {
        _form.save();
        _isLoading = true;
        user.name = name;
        user.school = school;
        _registerResponse.register(user);
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
          : Container(
              decoration: AppDecorations.mainDecoration,
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: RegisterBody(),
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
          await _registerServices.saveCacheData(user.id, user.name);
      if (savingDataValue == true) {
        setState(() {
          _isLoading = false;
        });
      } else {
        _showSnackBar('ocorreu um erro salvando seus dados, tente novamente');
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
