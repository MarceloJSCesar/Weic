import 'package:flutter/material.dart';
import 'package:weic/core/config/app_assets_names.dart';
import 'package:weic/core/config/app_decorations.dart';
import 'package:weic/core/config/app_textstyles.dart';
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

  String _sexualitySelected;
  final _sexualities = ['Masculino', 'Femenino'];
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
          : Container(
              decoration: AppDecorations.mainDecoration,
              child: Center(
                child: SingleChildScrollView(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.black,
                          shadowColor: Colors.black,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 50,
                            ),
                            child: Column(
                              children: <Widget>[
                                DropdownButton(
                                  dropdownColor: Colors.black,
                                  value: _sexualitySelected,
                                  style: AppTextStyles.dropDownTextStyle,
                                  onChanged: (value) {
                                    setState(() {
                                      _sexualitySelected = value;
                                      print(_sexualitySelected);
                                    });
                                  },
                                  hint: Text(
                                    'Seleciona seu sexo',
                                    style: AppTextStyles.dropDownTextStyle,
                                  ),
                                  items: _sexualities.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Seu Nome',
                                      hintStyle: AppTextStyles.hintTextStyle,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Nome Da Escola',
                                      hintStyle: AppTextStyles.hintTextStyle,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.blue,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text('Entrar'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 350,
                        left: MediaQuery.of(context).size.width / 2.5,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                            _sexualitySelected == 'Masculino'
                                ? AppAssetsNames.boyImageUrl
                                : AppAssetsNames.womanImageUrl,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  /*
  Container(
              decoration: AppDecorations.mainDecoration,
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            elevation: 8.0,
                            shadowColor: Colors.black,
                            clipBehavior: Clip.antiAlias,
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: <Widget>[
                                Positioned(
                                  top: 10,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      AppAssetsNames.boyImageUrl,
                                    ),
                                  ),
                                ),
                                DropdownButton(
                                  dropdownColor: Colors.black,
                                  value: _sexualitySelected,
                                  style: AppTextStyles.dropDownTextStyles,
                                  onChanged: (value) {
                                    setState(() {
                                      _sexualitySelected = value;
                                      print(_sexualitySelected);
                                    });
                                  },
                                  hint: Text('Seleciona seu sexo'),
                                  items: _sexualities.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                TextFormField(),
                                TextFormField(),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Entrar'),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
  */

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
