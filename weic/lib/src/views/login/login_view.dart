import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_textstyles.dart';
import '../../config/app_decorations.dart';
import '../../config/app_assetsnames.dart';
import '../../components/login/body/login_body.dart';
import '../../controllers/login/login_controller.dart';
import '../../components/login/textfield/app_text_field_component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  final _collection = FirebaseFirestore.instance.collection('user');

  void storedata() async {
    await _collection
        .add({'name': 'Marcelo', 'idade': '19 anos'})
        .then((value) => print('data stored $value'))
        .catchError((value) => print('error occured $value'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storedata();
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height,
              decoration: AppDecorations.mainDecoration,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LoginBody(
                      formkey: _formKey,
                      loginController: _loginController,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      onTap: () async => storedata(),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Developed by Marcelo Cesar',
                          style: AppTextStyles.blackTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
