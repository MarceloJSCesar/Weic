import 'package:flutter/material.dart';
// import 'package:weic/core/components/text_form_field_component.dart';
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

  String sexualitySelected;
  List<String> sexualities = ['Masculino', 'Femenino'];

  bool isPassword = false;

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
        user.sexuality = sexualitySelected;
      });
      await db.registerUser(user);
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
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextFormField(
                                          onSaved: (val) {
                                            name = val;
                                            print(name);
                                          },
                                          onChanged: (val) => name = val,
                                          style:
                                              AppTextStyles.dropDownTextStyle,
                                          textInputAction: isPassword
                                              ? TextInputAction.next
                                              : TextInputAction.done,
                                          decoration: InputDecoration(
                                            hintText: 'Seu Nome',
                                            hintStyle:
                                                AppTextStyles.hintTextStyle,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextFormField(
                                          onSaved: (val) {
                                            school = val;
                                            print(school);
                                          },
                                          onChanged: (val) => school = val,
                                          style:
                                              AppTextStyles.dropDownTextStyle,
                                          textInputAction: isPassword
                                              ? TextInputAction.next
                                              : TextInputAction.done,
                                          decoration: InputDecoration(
                                            hintText: 'Nome da escola',
                                            hintStyle:
                                                AppTextStyles.hintTextStyle,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextFormField(
                                          onSaved: (val) {
                                            email = val;
                                            print(email);
                                          },
                                          onChanged: (val) => email = val,
                                          style:
                                              AppTextStyles.dropDownTextStyle,
                                          textInputAction: isPassword
                                              ? TextInputAction.next
                                              : TextInputAction.done,
                                          decoration: InputDecoration(
                                            hintText: 'email',
                                            hintStyle:
                                                AppTextStyles.hintTextStyle,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextFormField(
                                          onSaved: (val) {
                                            password = val;
                                            print(password);
                                          },
                                          onChanged: (val) => password = val,
                                          style:
                                              AppTextStyles.dropDownTextStyle,
                                          textInputAction: isPassword == true
                                              ? TextInputAction.next
                                              : TextInputAction.done,
                                          decoration: InputDecoration(
                                            hintText: 'password',
                                            hintStyle:
                                                AppTextStyles.hintTextStyle,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
