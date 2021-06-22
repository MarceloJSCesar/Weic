import 'package:flutter/material.dart';
import 'package:weic/core/components/text_form_field_component.dart';
import 'package:weic/core/storage/db_storage.dart';
import '../../models/user.dart';
import '../../config/app_textstyles.dart';
import '../../config/app_decorations.dart';
import '../../config/app_assets_names.dart';
import '../../services/register_services.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String name, email, school, password, sexuality;
  RegisterServices _registerServices = RegisterServices();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String sexualitySelected;
  List<String> sexualities = ['Masculino', 'Femenino'];

  void _submit() async {
    User user = User();
    DbStorage db = DbStorage();
    final _form = _formKey.currentState;

    if (_form.validate()) {
      setState(() {
        _form.save();
        _isLoading = true;
        user.name = name;
        user.school = school;
        user.email = email;
        user.password = password;
        user.sexuality = sexuality;
        db.registerUser(user);
      });
      await _registerServices.saveCacheData(email, name);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed('/login');
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
                                        onChanged: (val) {
                                          setState(() {
                                            sexualitySelected = val;
                                          });
                                        },
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
                                        value: name,
                                        hintText: 'Seu Nome',
                                      ),
                                      Divider(),
                                      TextFormFieldComponent(
                                        value: school,
                                        hintText: 'Nome Da Escola',
                                      ),
                                      Divider(),
                                      TextFormFieldComponent(
                                        value: email,
                                        hintText: 'Email',
                                      ),
                                      Divider(),
                                      TextFormFieldComponent(
                                        value: password,
                                        hintText: 'Password',
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
                        Positioned(
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
