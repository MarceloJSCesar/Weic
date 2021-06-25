import 'package:flutter/material.dart';
import 'package:weic/core/components/text_form_field_component.dart';
import 'package:weic/core/config/app_colors.dart';
import 'package:weic/core/controllers/auth_services/auth_service.dart';
import 'package:weic/core/storage/db_storage.dart';
import '../../models/user.dart';
import '../../config/app_textstyles.dart';
import '../../config/app_decorations.dart';
import '../../config/app_assets_names.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String name, email, school, password;

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AuthService _auth = AuthService();

  bool fieldsValidate = true;
  String sexualitySelected;
  List<String> sexualities = ['Masculino', 'Femenino'];

  void _submit() async {
    User user = User();
    DbStorage db = DbStorage();
    // implement validation with _formKey after
    final _form = _formKey.currentState;

    if (_form.validate() && sexualitySelected != null) {
      setState(() {
        _form.save();
        _isLoading = true;
        user.name = name;
        user.school = school;
        user.email = email.trim();
        user.password = password.trim();
        user.sexuality = sexualitySelected;
        fieldsValidate = true;
      });
      await db.registerUser(user);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      if (sexualitySelected == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('seleciona seu sexo'),
          ),
        );
      }
      setState(() {
        fieldsValidate = false;
      });
    }
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
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              ClipOval(
                                child: Image(
                                  width: 300,
                                  image:
                                      AssetImage(AppAssetsNames.logoImageUrl),
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
                                    vertical: 30,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_drop_down),
                                        dropdownColor: Colors.black,
                                        value: sexualitySelected,
                                        style: AppTextStyles.dropDownTextStyle,
                                        onChanged: (val) => setState(() {
                                          sexualitySelected = val;
                                        }),
                                        hint: Text(
                                          'Seleciona seu sexo',
                                          style:
                                              AppTextStyles.dropDownTextStyle,
                                        ),
                                        items: sexualities.map((value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      TextFormFieldComponent(
                                        hintText: 'Nome, ex: Marcelo Cesar',
                                        saveValue: (val) => name = val,
                                        isPasswordField: false,
                                        isEmailField: false,
                                        validateField: (val) =>
                                            _auth.validateName(val),
                                      ),
                                      Divider(),
                                      TextFormFieldComponent(
                                        hintText: 'Nome da Escola, ex: Esad',
                                        saveValue: (val) => school = val,
                                        isPasswordField: false,
                                        isEmailField: false,
                                        validateField: (val) =>
                                            _auth.validateSchool(val),
                                      ),
                                      Divider(),
                                      TextFormFieldComponent(
                                        hintText:
                                            'Email, ex: marcelo@gmail.com',
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
                                        child: Text(
                                          'Registrar',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          'Ja tenho uma conta, Login',
                                          style: AppTextStyles.hintTextStyle,
                                        ),
                                        onTap: () => Navigator.of(context)
                                            .pushReplacementNamed('/login'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        fieldsValidate
                            ? Positioned(
                                bottom: 485,
                                left: MediaQuery.of(context).size.width / 2.3,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                    sexualitySelected == 'Masculino'
                                        ? AppAssetsNames.boyImageUrl
                                        : AppAssetsNames.womanImageUrl,
                                  ),
                                ),
                              )
                            : Positioned(
                                bottom: 505,
                                left: MediaQuery.of(context).size.width / 200,
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundImage: AssetImage(
                                    sexualitySelected == 'Masculino'
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
            ),
    );
  }
}
