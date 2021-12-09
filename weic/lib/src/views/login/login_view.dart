import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_textstyles.dart';
import '../../config/app_decorations.dart';
import '../../config/app_assetsnames.dart';
import '../../components/login/body/login_body.dart';
import '../../controllers/login/login_controller.dart';
import '../../components/login/textfield/app_text_field_component.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
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
                  children: <Widget>[
                    Image(
                      width: 200,
                      fit: BoxFit.fill,
                      image: AssetImage(AppAssetsNames.logoImageUrl),
                    ),
                    LoginBody(
                      loginController: _loginController,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      'Developed by Marcelo Cesar',
                      style: AppTextStyles.blackTextStyle,
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
